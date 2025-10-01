import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class MockApiService {
  static const int _minDelay = 500; // Minimum delay in milliseconds
  static const int _maxDelay = 2000; // Maximum delay in milliseconds
  
  static final Random _random = Random();

  /// Simulates network delay
  static Future<void> _simulateNetworkDelay() async {
    final delay = _minDelay + _random.nextInt(_maxDelay - _minDelay);
    await Future.delayed(Duration(milliseconds: delay));
  }

  /// Loads JSON data from assets with simulated network delay
  static Future<List<dynamic>> loadMockData(String assetPath) async {
    try {
      // Simulate network delay
      await _simulateNetworkDelay();
      
      // Load the JSON file from assets
      final String jsonString = await rootBundle.loadString('assets/$assetPath');
      final List<dynamic> data = json.decode(jsonString);
      
      return data;
    } catch (e) {
      throw Exception('Failed to load mock data from $assetPath: $e');
    }
  }

  /// Loads UI schema from assets
  static Future<Map<String, dynamic>> loadUISchema() async {
    try {
      await _simulateNetworkDelay();
      
      final String jsonString = await rootBundle.loadString('assets/ui_schema.json');
      final Map<String, dynamic> schema = json.decode(jsonString);
      
      return schema;
    } catch (e) {
      throw Exception('Failed to load UI schema: $e');
    }
  }

  /// Simulates form submission
  static Future<Map<String, dynamic>> submitForm(Map<String, dynamic> formData) async {
    try {
      await _simulateNetworkDelay();
      
      // Simulate successful submission
      return {
        'success': true,
        'message': 'Form submitted successfully!',
        'submittedData': formData,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      throw Exception('Failed to submit form: $e');
    }
  }

  // Specific methods for different data types
  static Future<List<dynamic>> getJobs() => loadMockData('mock/jobs.json');
  static Future<List<dynamic>> getDesignations() => loadMockData('mock/designations.json');
  static Future<List<dynamic>> getCountries() => loadMockData('mock/countries.json');
  static Future<List<dynamic>> getStates() => loadMockData('mock/states.json');
  static Future<List<dynamic>> getCities() => loadMockData('mock/cities.json');
  static Future<List<dynamic>> getProfileStatuses() => loadMockData('mock/profile_status.json');
  static Future<List<dynamic>> getEducationLevels() => loadMockData('mock/education_levels.json');
}