import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/bottom_screen/home_screen.dart';

void main() {
  testWidgets('HomeScreen shows greeting and focus', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: HomeScreen()),
    );

    expect(find.textContaining('Namaste, Manisha'), findsOneWidget);
    expect(find.text("Today's Focus:"), findsOneWidget);
  });
}
