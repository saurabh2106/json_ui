class FormValidators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  static String? pincode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Pincode is required';
    }
    
    final pincodeRegex = RegExp(r'^\d{6}$');
    if (!pincodeRegex.hasMatch(value.trim())) {
      return 'Please enter a valid 6-digit pincode';
    }
    
    return null;
  }

  static String? percentage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }
    
    final percentage = double.tryParse(value.trim());
    if (percentage == null || percentage < 0 || percentage > 100) {
      return 'Please enter a valid percentage (0-100)';
    }
    
    return null;
  }

  static String? year(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Year is required';
    }
    
    final year = int.tryParse(value.trim());
    final currentYear = DateTime.now().year;
    
    if (year == null || year < 1950 || year > currentYear) {
      return 'Please enter a valid year (1950-$currentYear)';
    }
    
    return null;
  }

  static String? experience(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Experience is required';
    }
    
    final exp = double.tryParse(value.trim());
    if (exp == null || exp < 0 || exp > 50) {
      return 'Please enter valid experience (0-50 years)';
    }
    
    return null;
  }

  static String? Function(String?) getValidator(String? validationType) {
    switch (validationType) {
      case 'required':
        return required;
      case 'email':
        return email;
      case 'phone':
        return phone;
      case 'pincode':
        return pincode;
      case 'percentage':
        return percentage;
      case 'year':
        return year;
      case 'experience':
        return experience;
      default:
        return null;
    }
  }

  static String? combineValidators(String? value, List<String> validatorTypes) {
    for (String validatorType in validatorTypes) {
      final validator = getValidator(validatorType);
      if (validator != null) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
    }
    return null;
  }
}