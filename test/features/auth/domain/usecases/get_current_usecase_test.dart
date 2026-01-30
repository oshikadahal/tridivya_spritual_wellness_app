import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/entities/auth_entity.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/usecases/get_current_usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockRepository;
  late GetCurrentUserUseCase usecase;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = GetCurrentUserUseCase(authRepository: mockRepository);
  });

  const tUser = AuthEntity(
    authId: '1',
    fullName: 'Test User',
    email: 'test@example.com',
    username: 'testuser',
    password: null,
  );

  test('should return AuthEntity when user exists', () async {
    when(() => mockRepository.getCurrentUser())
        .thenAnswer((_) async => const Right(tUser));

    final result = await usecase();

    expect(result, const Right(tUser));
    verify(() => mockRepository.getCurrentUser()).called(1);
  });

  test('should return failure when user is missing', () async {
    const failure = LocalDatabaseFailure(message: 'No user logged in');
    when(() => mockRepository.getCurrentUser())
        .thenAnswer((_) async => const Left(failure));

    final result = await usecase();

    expect(result, const Left(failure));
    verify(() => mockRepository.getCurrentUser()).called(1);
  });
}
