import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tridivya_spritual_wellness_app/features/auth/domain/usecases/update_profile_usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockRepository;
  late UpdateProfileUseCase usecase;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = UpdateProfileUseCase(authRepository: mockRepository);
  });

  const imagePath = 'path/to/image.jpg';

  test('should return image path when upload is successful', () async {
    when(() => mockRepository.updateProfileImage(imagePath))
        .thenAnswer((_) async => const Right('/uploads/image.jpg'));

    final result = await usecase(const UpdateProfileParams(imagePath: imagePath));

    expect(result, const Right('/uploads/image.jpg'));
    verify(() => mockRepository.updateProfileImage(imagePath)).called(1);
  });

  test('should return failure when upload fails', () async {
    const failure = ApiFailure(message: 'Upload failed');
    when(() => mockRepository.updateProfileImage(imagePath))
        .thenAnswer((_) async => const Left(failure));

    final result = await usecase(const UpdateProfileParams(imagePath: imagePath));

    expect(result, const Left(failure));
    verify(() => mockRepository.updateProfileImage(imagePath)).called(1);
  });
}


