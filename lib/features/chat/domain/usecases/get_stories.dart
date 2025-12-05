import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/story.dart';
import '../repositories/chat_repository.dart';

class GetStories implements UseCase<List<Story>, NoParams> {
  final ChatRepository repository;

  GetStories(this.repository);

  @override
  Future<Either<Failure, List<Story>>> call(NoParams params) async {
    return await repository.getStories();
  }
}
