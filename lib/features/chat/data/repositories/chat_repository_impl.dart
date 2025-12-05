import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/story.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_local_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataSource localDataSource;

  ChatRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Chat>>> getChats() async {
    try {
      final chats = await localDataSource.getChats();
      return Right(chats);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Story>>> getStories() async {
    try {
      final stories = await localDataSource.getStories();
      return Right(stories);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
