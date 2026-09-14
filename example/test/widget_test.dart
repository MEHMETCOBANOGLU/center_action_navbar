import 'package:center_action_navbar_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('example app loads with navbar', (tester) async {
    await tester.pumpWidget(const CenterActionNavbarExampleApp());
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
    expect(find.byIcon(Icons.add_rounded), findsOneWidget);
  });
}
