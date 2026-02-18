import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/presentation/pages/signup_page.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:tridivya_spritual_wellness_app/core/services/storage/user_session_service.dart';
import '../../../../utils/test_asset_bundle.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}
class MockUserSessionService extends Mock implements UserSessionService {}

void main() {
  testWidgets('SignupPage renders all fields and signup button', (tester) async {
    final mockRepo = MockAuthRepository();
    final mockSessionService = MockUserSessionService();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockRepo, mockSessionService),
          ),
        ],
        child: DefaultAssetBundle(
          bundle: TestAssetBundle(),
          child: const MaterialApp(home: SignupPage()),
        ),
      ),
    );

    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });
}
