import 'package:multiple_result/multiple_result.dart';

import '../errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Failure, Type>> call(Params params);
}

abstract class UseCaseNoParam<Type> {
  Future<Result<Failure, Type>> call();
}
