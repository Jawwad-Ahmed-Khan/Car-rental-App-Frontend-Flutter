import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

/// Base UseCase class for domain logic
/// 
/// Type: The return type wrapped in Either
/// Params: The parameters required to execute the use case
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// UseCase with no parameters
class NoParams {}
