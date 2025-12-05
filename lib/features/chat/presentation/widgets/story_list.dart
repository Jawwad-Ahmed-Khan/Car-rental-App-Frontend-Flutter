import 'package:flutter/material.dart';
import '../../domain/entities/story.dart';
import 'custom_avatar.dart';

class StoryList extends StatelessWidget {
  final List<Story> stories;

  const StoryList({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final story = stories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: story.id == '1' // "Add story" case
                        ? null
                        : Border.all(
                            color: story.isViewed ? Colors.grey : Colors.blue,
                            width: 2,
                          ),
                  ),
                  child: story.id == '1'
                      ? const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.add, color: Colors.black, size: 30),
                        )
                      : CustomAvatar(
                          imageUrl: story.avatarUrl,
                          radius: 30,
                        ),
                ),
                const SizedBox(height: 5),
                Text(
                  story.name,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
