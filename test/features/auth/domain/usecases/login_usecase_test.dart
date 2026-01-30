import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/entities/auth_entity.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/usecases/login_usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockRepository;
  late LoginUseCase usecase;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = LoginUseCase(authRepository: mockRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUser = AuthEntity(
    authId: '1',
    fullName: 'Test User',
    email: tEmail,
    username: 'testuser',
    password: null,
  );

  test('should return AuthEntity when login is successful', () async {
    when(() => mockRepository.login(tEmail, tPassword))
        .thenAnswer((_) async => const Right(tUser));

    final result = await usecase(
      const LoginParams(email: tEmail, password: tPassword),
    );

    expect(result, const Right(tUser));
    verify(() => mockRepository.login(tEmail, tPassword)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when login fails', () async {
    const failure = ApiFailure(message: 'Invalid credentials');
    when(() => mockRepository.login(tEmail, tPassword))
        .thenAnswer((_) async => const Left(failure));

    final result = await usecase(
      const LoginParams(email: tEmail, password: tPassword),
    );

    expect(result, const Left(failure));
    verify(() => mockRepository.login(tEmail, tPassword)).called(1);
  });
}
