# JSON UI Flutter App

A Flutter application that dynamically renders UI screens from JSON schema using the STAC package. This project demonstrates how to create data-driven user interfaces with mock API integration.

## Features

- **Dynamic UI Rendering**: Builds Flutter widgets from JSON schema definitions
- **Mock API Integration**: Simulates real API calls with network delays
- **Form Validation**: Comprehensive validation for different field types
- **Responsive Design**: Adaptive UI that works across different screen sizes
- **Error Handling**: Robust error handling with user-friendly messages
- **Loading States**: Proper loading indicators during data fetching

## Project Structure

```
lib/
├── main.dart                     # Main application entry point
├── models/
│   └── form_models.dart         # Data models for forms and validation
├── services/
│   └── mock_api_service.dart    # Mock API service with simulated delays
├── utils/
│   └── form_validators.dart     # Form validation utilities
└── widgets/
    └── dynamic_form_renderer.dart # Custom widget renderer for JSON schema

assets/
├── ui_schema.json               # Main UI schema definition
└── mock/                        # Mock API data files
    ├── jobs.json
    ├── designations.json
    ├── countries.json
    ├── states.json
    ├── cities.json
    ├── profile_status.json
    └── education_levels.json
```

## Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd json_ui
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

## JSON Schema Format

The application uses a custom JSON schema format that defines the UI structure. Here's an example:

```json
{
  "type": "Scaffold",
  "appBar": {
    "type": "AppBar",
    "title": "Profile Screen"
  },
  "body": {
    "type": "SingleChildScrollView",
    "child": {
      "type": "Column",
      "children": [
        {
          "type": "TextFormField",
          "decoration": {
            "labelText": "First Name",
            "border": "OutlineInputBorder"
          },
          "validator": "required"
        }
      ]
    }
  }
}
```

### Supported Widget Types

- `Scaffold` - Main screen structure
- `AppBar` - Application bar
- `Column` - Vertical layout
- `Card` - Material design card
- `TextFormField` - Text input field
- `DropdownButtonFormField` - Dropdown selection
- `ElevatedButton` - Action button
- `Text` - Text display
- `SizedBox` - Spacing and sizing
- `Padding` - Padding wrapper
- `SingleChildScrollView` - Scrollable content

### Form Field Configuration

#### Text Fields
```json
{
  "type": "TextFormField",
  "decoration": {
    "labelText": "Field Label",
    "border": "OutlineInputBorder"
  },
  "validator": "required",
  "keyboardType": "email"
}
```

#### Dropdown Fields
```json
{
  "type": "DropdownButtonFormField",
  "decoration": {
    "labelText": "Select Option",
    "border": "OutlineInputBorder"
  },
  "items": {
    "source": "mock/countries.json",
    "valueField": "id",
    "displayField": "name"
  }
}
```

## Mock API Service

The `MockApiService` simulates real API behavior with:

- **Network Delays**: Random delays between 500ms-2000ms
- **Error Simulation**: Configurable error scenarios
- **Data Loading**: Loads JSON files from assets
- **Form Submission**: Simulates form submission with response

### Available Endpoints

- `getJobs()` - Fetch available job positions
- `getDesignations()` - Fetch job designations
- `getCountries()` - Fetch country list
- `getStates()` - Fetch state/province list
- `getCities()` - Fetch city list
- `getProfileStatuses()` - Fetch profile status options
- `getEducationLevels()` - Fetch education level options

## Form Validation

The application includes comprehensive form validation:

- **Required Fields**: Ensures mandatory fields are filled
- **Email Validation**: Validates email format
- **Phone Validation**: Validates phone number format
- **Pincode Validation**: Validates 6-digit postal codes
- **Percentage Validation**: Validates percentage values (0-100)
- **Year Validation**: Validates year ranges
- **Experience Validation**: Validates work experience values

## Customization

### Adding New Widget Types

1. Add the widget type to the `_buildWidget` method in `DynamicFormRenderer`
2. Implement the widget creation logic
3. Update the JSON schema to use the new widget type

### Adding New Validation Rules

1. Add the validation function to `FormValidators`
2. Update the `getValidator` method to include the new rule
3. Use the validation rule in your JSON schema

### Adding New Mock Data

1. Create a new JSON file in `assets/mock/`
2. Add the file to `pubspec.yaml` assets
3. Create a corresponding method in `MockApiService`
4. Update the dropdown data loading in `DynamicFormRenderer`

## Production Considerations

- Replace mock API service with real API integration
- Implement proper error handling and retry mechanisms
- Add authentication and authorization
- Implement data persistence and caching
- Add comprehensive testing
- Optimize performance for large forms
- Add accessibility features
- Implement proper state management (Provider, Bloc, etc.)

## Dependencies

- `flutter`: Flutter SDK
- `stac`: ^0.11.0 - Schema-driven UI components
- `cupertino_icons`: ^1.0.8 - iOS-style icons

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.