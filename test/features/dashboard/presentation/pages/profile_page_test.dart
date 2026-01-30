import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tridivya_spritual_wellness_app/core/services/storage/user_session_service.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/profile_page.dart';
import '../../../../utils/test_asset_bundle.dart';

class MockUserSessionService extends Mock implements UserSessionService {}

void main() {
  testWidgets('ProfilePage shows user info and camera icon', (tester) async {
    final mockSession = MockUserSessionService();
    when(() => mockSession.getCurrentUserFullName()).thenReturn('Test User');
    when(() => mockSession.getCurrentUserEmail())
        .thenReturn('test@example.com');
    when(() => mockSession.getCurrentUserProfilePicture()).thenReturn('');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userSessionServiceProvider.overrideWithValue(mockSession),
        ],
        child: DefaultAssetBundle(
          bundle: TestAssetBundle(),
          child: const MaterialApp(home: ProfileScreen()),
        ),
      ),
    );

    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Test User'), findsOneWidget);
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.byIcon(Icons.camera_alt), findsOneWidget);
  });
}
