import '../../domain/entities/story.dart';

class StoryModel extends Story {
  const StoryModel({
    required super.id,
    required super.name,
    required super.avatarUrl,
    required super.isViewed,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      isViewed: json['isViewed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'isViewed': isViewed,
    };
  }
}
