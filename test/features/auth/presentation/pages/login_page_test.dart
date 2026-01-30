import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/presentation/pages/login_page.dart';
import '../../../../utils/test_asset_bundle.dart';

void main() {
  testWidgets('LoginPage renders email, password and sign in', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: DefaultAssetBundle(
          bundle: TestAssetBundle(),
          child: const MaterialApp(home: LoginPage()),
        ),
      ),
    );

    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
