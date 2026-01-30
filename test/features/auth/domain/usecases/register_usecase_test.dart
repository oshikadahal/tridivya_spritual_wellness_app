import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/entities/auth_entity.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/usecases/register_usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const AuthEntity(
        authId: 'fallback',
        fullName: 'Fallback',
        email: 'fallback@example.com',
        username: 'fallback',
        password: 'fallback',
      ),
    );
  });

  late MockAuthRepository mockRepository;
  late RegisterUseCase usecase;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = RegisterUseCase(authRepository: mockRepository);
  });

  const tFullName = 'Test User';
  const tEmail = 'test@example.com';
  const tUsername = 'testuser';
  const tPassword = 'password123';

  test('should pass correct entity to repository', () async {
    AuthEntity? captured;
    when(() => mockRepository.register(any())).thenAnswer((invocation) async {
      captured = invocation.positionalArguments[0] as AuthEntity;
      return const Right(true);
    });

    await usecase(
      const RegisterParams(
        fullName: tFullName,
        email: tEmail,
        username: tUsername,
        password: tPassword,
      ),
    );

    expect(captured?.fullName, tFullName);
    expect(captured?.email, tEmail);
    expect(captured?.username, tUsername);
    expect(captured?.password, tPassword);
  });

  test('should return failure when registration fails', () async {
    const failure = ApiFailure(message: 'Registration failed');
    when(() => mockRepository.register(any()))
        .thenAnswer((_) async => const Left(failure));

    final result = await usecase(
      const RegisterParams(
        fullName: tFullName,
        email: tEmail,
        username: tUsername,
        password: tPassword,
      ),
    );

    expect(result, const Left(failure));
    verify(() => mockRepository.register(any())).called(1);
  });
}
