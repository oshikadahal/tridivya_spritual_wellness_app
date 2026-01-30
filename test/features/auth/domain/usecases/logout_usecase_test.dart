import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/usecases/logout_usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockRepository;
  late LogoutUseCase usecase;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = LogoutUseCase(authRepository: mockRepository);
  });

  test('should return true when logout succeeds', () async {
    when(() => mockRepository.logout())
        .thenAnswer((_) async => const Right(true));

    final result = await usecase();

    expect(result, const Right(true));
    verify(() => mockRepository.logout()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when logout fails', () async {
    const failure = LocalDatabaseFailure(message: 'Logout failed');
    when(() => mockRepository.logout())
        .thenAnswer((_) async => const Left(failure));

    final result = await usecase();

    expect(result, const Left(failure));
    verify(() => mockRepository.logout()).called(1);
  });
}
