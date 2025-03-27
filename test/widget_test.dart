// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pricecheck/main.dart';

void main() {
  testWidgets('App loads and displays Home Screen',
      (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the Home Screen is displayed.
    expect(find.text('Home Screen'), findsOneWidget);
    expect(find.text('Cart Screen'), findsNothing);

    // Tap the Cart tab and trigger a frame.
    await tester.tap(find.text('Cart'));
    await tester.pump();

    // Verify that the Cart Screen is displayed.
    expect(find.text('Cart Screen'), findsOneWidget);
    expect(find.text('Home Screen'), findsNothing);
  });
}
