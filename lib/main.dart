import 'package:flutter/material.dart';
import 'services/mock_api_service.dart';
import 'widgets/dynamic_form_renderer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON UI Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const JsonUIScreen(),
    );
  }
}

class JsonUIScreen extends StatefulWidget {
  const JsonUIScreen({super.key});

  @override
  State<JsonUIScreen> createState() => _JsonUIScreenState();
}

class _JsonUIScreenState extends State<JsonUIScreen> {
  Map<String, dynamic>? _uiSchema;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUISchema();
  }

  Future<void> _loadUISchema() async {
    try {
      final schema = await MockApiService.loadUISchema();
      setState(() {
        _uiSchema = schema;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _handleFormSubmit(Map<String, dynamic> formData) {
    // Handle successful form submission
    print('Form submitted with data: $formData');
    
    // You can navigate to a success page or perform other actions here
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Form submitted successfully!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading UI Schema...'),
            ],
          ),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to load UI schema',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _error = null;
                  });
                  _loadUISchema();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_uiSchema == null) {
      return const Scaffold(
        body: Center(
          child: Text('No UI schema available'),
        ),
      );
    }

    return DynamicFormRenderer(
      schema: _uiSchema!,
      onSubmit: _handleFormSubmit,
    );
  }
}