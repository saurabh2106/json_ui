# JSON UI Flutter App

A Flutter application that dynamically renders UI screens from JSON schema. This project demonstrates how to create data-driven user interfaces with mock API integration.

## Features

- **Dynamic UI Rendering**: Builds Flutter widgets from JSON schema definitions.
- **Mock API Integration**: Simulates real API calls with network delays.
- **Responsive Design**: Adaptive UI that works across different screen sizes.
- **Error Handling**: Robust error handling with user-friendly messages.
- **Loading States**: Proper loading indicators during data fetching.

## Project Structure

```
lib/
├── main.dart                     # Main application entry point
├── services/
│   └── mock_api_service.dart    # Mock API service with simulated delays
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

## Dependencies

- `flutter`: Flutter SDK
- `stac`: ^0.11.0 - Schema-driven UI components
- `cupertino_icons`: ^1.0.8 - iOS-style icons

## License

This project is licensed under the MIT License - see the LICENSE file for details.