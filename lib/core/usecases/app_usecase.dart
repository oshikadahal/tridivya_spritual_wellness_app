import 'package:dartz/dartz.dart';
import 'package:tridivya_spritual_wellness_app/core/error/failures.dart';

abstract interface class UseCaseWithParams<SuccessType, ParamsType> {
  Future<Either<Failure, SuccessType>> call(ParamsType params);
}

abstract interface class UseCaseWithoutParams<SuccessType> {
  Future<Either<Failure, SuccessType>> call();
}
