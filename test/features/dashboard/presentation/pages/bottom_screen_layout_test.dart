import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/bottom_screen_layout.dart';

void main() {
  testWidgets('BottomScreenLayout shows navigation items', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: BottomScreenLayout()),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Sessions'), findsOneWidget);
    expect(find.text('Progress'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
