import 'package:flutter/material.dart';
import '../services/mock_api_service.dart';

class DynamicFormRenderer extends StatefulWidget {
  final Map<String, dynamic> schema;
  final Function(Map<String, dynamic>)? onSubmit;

  const DynamicFormRenderer({
    super.key,
    required this.schema,
    this.onSubmit,
  });

  @override
  State<DynamicFormRenderer> createState() => _DynamicFormRendererState();
}

class _DynamicFormRendererState extends State<DynamicFormRenderer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  final Map<String, List<dynamic>> _dropdownData = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Load all dropdown data
      final jobs = await MockApiService.getJobs();
      final designations = await MockApiService.getDesignations();
      final countries = await MockApiService.getCountries();
      final states = await MockApiService.getStates();
      final cities = await MockApiService.getCities();
      final profileStatuses = await MockApiService.getProfileStatuses();
      final educationLevels = await MockApiService.getEducationLevels();

      setState(() {
        _dropdownData['mock/jobs.json'] = jobs;
        _dropdownData['mock/designations.json'] = designations;
        _dropdownData['mock/countries.json'] = countries;
        _dropdownData['mock/states.json'] = states;
        _dropdownData['mock/cities.json'] = cities;
        _dropdownData['mock/profile_status.json'] = profileStatuses;
        _dropdownData['mock/education_levels.json'] = educationLevels;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    }
  }

  Widget _buildWidget(Map<String, dynamic> config) {
    final type = config['type'] as String;

    switch (type) {
      case 'Scaffold':
        return Scaffold(
          appBar: config['appBar'] != null ? _buildAppBar(config['appBar']) : null,
          body: config['body'] != null ? _buildWidget(config['body']) : Container(),
        );

      case 'AppBar':
        return Container(); // AppBar is handled in Scaffold case

      case 'SingleChildScrollView':
        return SingleChildScrollView(
          child: config['child'] != null ? _buildWidget(config['child']) : Container(),
        );

      case 'Padding':
        final padding = config['padding'] as Map<String, dynamic>?;
        EdgeInsets edgeInsets = EdgeInsets.zero;
        if (padding != null) {
          if (padding.containsKey('all')) {
            edgeInsets = EdgeInsets.all(padding['all'].toDouble());
          }
        }
        return Padding(
          padding: edgeInsets,
          child: config['child'] != null ? _buildWidget(config['child']) : Container(),
        );

      case 'Column':
        final children = config['children'] as List<dynamic>? ?? [];
        return Column(
          crossAxisAlignment: _getCrossAxisAlignment(config['crossAxisAlignment']),
          children: children.map((child) => _buildWidget(child)).toList(),
        );

      case 'Card':
        return Card(
          child: config['child'] != null ? _buildWidget(config['child']) : Container(),
        );

      case 'Text':
        return Text(
          config['data'] as String? ?? '',
          style: _getTextStyle(config['style']),
        );

      case 'SizedBox':
        return SizedBox(
          height: config['height']?.toDouble(),
          width: config['width'] == 'double.infinity' ? double.infinity : config['width']?.toDouble(),
          child: config['child'] != null ? _buildWidget(config['child']) : null,
        );

      case 'TextFormField':
        return _buildTextFormField(config);

      case 'DropdownButtonFormField':
        return _buildDropdownFormField(config);

      case 'ElevatedButton':
        return ElevatedButton(
          onPressed: () => _handleButtonPress(config['onPressed']),
          child: config['child'] != null ? _buildWidget(config['child']) : Container(),
        );

      default:
        return Text('Unknown widget type: $type');
    }
  }

  AppBar _buildAppBar(Map<String, dynamic> config) {
    return AppBar(
      title: Text(config['title'] as String? ?? ''),
    );
  }

  Widget _buildTextFormField(Map<String, dynamic> config) {
    final decoration = config['decoration'] as Map<String, dynamic>?;
    final validator = config['validator'] as String?;
    final keyboardType = config['keyboardType'] as String?;

    return TextFormField(
      decoration: InputDecoration(
        labelText: decoration?['labelText'] as String?,
        border: decoration?['border'] == 'OutlineInputBorder' 
            ? const OutlineInputBorder() 
            : null,
      ),
      keyboardType: _getKeyboardType(keyboardType),
      validator: validator == 'required' 
          ? (value) => value?.isEmpty == true ? 'This field is required' : null
          : null,
      onSaved: (value) {
        final labelText = decoration?['labelText'] as String?;
        if (labelText != null) {
          _formData[labelText] = value ?? '';
        }
      },
    );
  }

  Widget _buildDropdownFormField(Map<String, dynamic> config) {
    final decoration = config['decoration'] as Map<String, dynamic>?;
    final validator = config['validator'] as String?;
    final items = config['items'] as Map<String, dynamic>?;

    if (items == null) return Container();

    final source = items['source'] as String?;
    final valueField = items['valueField'] as String?;
    final displayField = items['displayField'] as String?;

    if (source == null || !_dropdownData.containsKey(source)) {
      return const Text('Loading...');
    }

    final data = _dropdownData[source]!;

    return DropdownButtonFormField<dynamic>(
      decoration: InputDecoration(
        labelText: decoration?['labelText'] as String?,
        border: decoration?['border'] == 'OutlineInputBorder' 
            ? const OutlineInputBorder() 
            : null,
      ),
      validator: validator == 'required' 
          ? (value) => value == null ? 'This field is required' : null
          : null,
      items: data.map<DropdownMenuItem<dynamic>>((item) {
        return DropdownMenuItem<dynamic>(
          value: item[valueField],
          child: Text(item[displayField]?.toString() ?? ''),
        );
      }).toList(),
      onChanged: (value) {
        final labelText = decoration?['labelText'] as String?;
        if (labelText != null) {
          _formData[labelText] = value;
        }
      },
    );
  }

  CrossAxisAlignment _getCrossAxisAlignment(String? alignment) {
    switch (alignment) {
      case 'start':
        return CrossAxisAlignment.start;
      case 'end':
        return CrossAxisAlignment.end;
      case 'center':
        return CrossAxisAlignment.center;
      default:
        return CrossAxisAlignment.start;
    }
  }

  TextStyle? _getTextStyle(Map<String, dynamic>? style) {
    if (style == null) return null;

    return TextStyle(
      fontSize: style['fontSize']?.toDouble(),
      fontWeight: style['fontWeight'] == 'bold' ? FontWeight.bold : null,
    );
  }

  TextInputType _getKeyboardType(String? type) {
    switch (type) {
      case 'emailAddress':
        return TextInputType.emailAddress;
      case 'phone':
        return TextInputType.phone;
      case 'number':
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  void _handleButtonPress(String? action) {
    if (action == 'handleSubmit') {
      _handleSubmit();
    }
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();

      setState(() {
        _isLoading = true;
      });

      try {
        final result = await MockApiService.submitForm(_formData);
        
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] as String),
            backgroundColor: Colors.green,
          ),
        );

        if (widget.onSubmit != null) {
          widget.onSubmit!(_formData);
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error submitting form: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Form(
      key: _formKey,
      child: _buildWidget(widget.schema),
    );
  }
}