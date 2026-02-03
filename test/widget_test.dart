import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:soul_cards/main.dart';

void main() {
  testWidgets('App launches and shows landing screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SoulCardsApp());

    // Verify that the app builds without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
