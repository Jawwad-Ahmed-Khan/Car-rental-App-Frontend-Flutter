import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chat.dart';
import '../entities/story.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<Chat>>> getChats();
  Future<Either<Failure, List<Story>>> getStories();
}
