// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bangladesh_agro_marketplace/main.dart';

void main() {
  testWidgets('App starts and shows login screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(AgroMobileApp());

    // Verify that the login screen is displayed
    expect(find.text('Bangladesh Agro'), findsOneWidget);
    expect(find.text('Marketplace'), findsOneWidget);
    expect(find.text('Connecting farmers with buyers'), findsOneWidget);
  });
}