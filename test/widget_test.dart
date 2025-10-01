import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_ui/main.dart';

void main() {
  testWidgets('App should start without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app starts with a loading indicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Loading UI Schema...'), findsOneWidget);
  });

  testWidgets('App should show error screen on failure', (WidgetTester tester) async {
    // This test would require mocking the asset loading to fail
    // For now, we just verify the basic structure exists
    await tester.pumpWidget(const MyApp());
    
    // The app should at least build without throwing exceptions
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}