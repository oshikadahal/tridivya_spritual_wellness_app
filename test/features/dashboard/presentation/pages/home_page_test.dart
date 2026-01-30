import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/home_page.dart';

void main() {
  testWidgets('HomeScreen shows title', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: HomeScreen()),
    );

    expect(find.text('Mindful Moments'), findsOneWidget);
    expect(find.text('Welcome, Anya!'), findsOneWidget);
  });
}
