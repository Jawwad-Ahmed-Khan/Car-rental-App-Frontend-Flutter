import 'package:equatable/equatable.dart';

class Story extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isViewed;

  const Story({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.isViewed,
  });

  @override
  List<Object?> get props => [id, name, avatarUrl, isViewed];
}
