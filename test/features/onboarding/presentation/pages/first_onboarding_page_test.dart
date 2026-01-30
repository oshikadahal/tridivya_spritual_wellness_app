import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tridivya_spritual_wellness_app/features/onboarding/presentation/pages/first_onboarding_page.dart';
import '../../../../utils/test_asset_bundle.dart';

void main() {
  testWidgets('FirstOnboardingScreen shows title and Next button', (tester) async {
    await tester.pumpWidget(
      DefaultAssetBundle(
        bundle: TestAssetBundle(),
        child: const MaterialApp(home: FirstOnboardingScreen()),
      ),
    );

    expect(find.text('Tridivya'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });
}
