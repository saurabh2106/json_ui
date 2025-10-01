class DropdownItem {
  final dynamic id;
  final String name;
  final Map<String, dynamic>? additionalData;

  DropdownItem({
    required this.id,
    required this.name,
    this.additionalData,
  });

  factory DropdownItem.fromJson(Map<String, dynamic> json) {
    return DropdownItem(
      id: json['id'],
      name: json['name'] ?? json['jobTitle'] ?? '',
      additionalData: json,
    );
  }
}

class FormFieldConfig {
  final String fieldName;
  final String label;
  final String controlType;
  final bool isRequired;
  final bool isEditable;
  final String? validationType;
  final String? keyboardType;
  final DropdownConfig? dropdownConfig;

  FormFieldConfig({
    required this.fieldName,
    required this.label,
    required this.controlType,
    this.isRequired = false,
    this.isEditable = true,
    this.validationType,
    this.keyboardType,
    this.dropdownConfig,
  });
}

class DropdownConfig {
  final String source;
  final String valueField;
  final String displayField;
  final String? filterField;
  final dynamic filterValue;

  DropdownConfig({
    required this.source,
    required this.valueField,
    required this.displayField,
    this.filterField,
    this.filterValue,
  });
}

class FormSection {
  final String title;
  final int order;
  final List<FormFieldConfig> fields;

  FormSection({
    required this.title,
    required this.order,
    required this.fields,
  });
}

class FormSubmissionResult {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;
  final String? error;

  FormSubmissionResult({
    required this.success,
    required this.message,
    this.data,
    this.error,
  });

  factory FormSubmissionResult.success(String message, Map<String, dynamic> data) {
    return FormSubmissionResult(
      success: true,
      message: message,
      data: data,
    );
  }

  factory FormSubmissionResult.error(String error) {
    return FormSubmissionResult(
      success: false,
      message: 'Submission failed',
      error: error,
    );
  }
}