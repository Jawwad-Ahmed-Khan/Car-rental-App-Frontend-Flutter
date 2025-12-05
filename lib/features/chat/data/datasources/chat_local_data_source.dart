import '../models/chat_model.dart';
import '../models/story_model.dart';

abstract class ChatLocalDataSource {
  Future<List<ChatModel>> getChats();
  Future<List<StoryModel>> getStories();
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  @override
  Future<List<ChatModel>> getChats() async {
    // Mock data based on the provided image
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate delay
    return const [
      ChatModel(
        id: '1',
        name: 'Hela Quintin',
        avatarUrl: 'assets/images/user1.png', // Placeholder, will need to ensure assets exist or use network images
        lastMessage: 'Your car is on the way! It will arrive.......',
        time: '09:20 am',
        unreadCount: 2,
        isOnline: true,
      ),
      ChatModel(
        id: '2',
        name: 'Cameron',
        avatarUrl: 'assets/images/user2.png',
        lastMessage: 'Ok, thanks!',
        time: '09:20 am',
        unreadCount: 1,
        isOnline: true,
      ),
      ChatModel(
        id: '3',
        name: 'Mr. Davit',
        avatarUrl: 'assets/images/user3.png',
        lastMessage: 'Thank you for booking with us! ......',
        time: '08:30 am',
        unreadCount: 0,
        isOnline: true,
      ),
      ChatModel(
        id: '4',
        name: 'Richard',
        avatarUrl: 'assets/images/user4.png',
        lastMessage: 'You: A voice massage',
        time: '07:32 am',
        unreadCount: 0,
        isOnline: false,
      ),
      ChatModel(
        id: '5',
        name: 'Maichel',
        avatarUrl: 'assets/images/user5.png',
        lastMessage: 'You: It was an amazing and smooth .....',
        time: 'Yesterday',
        unreadCount: 0,
        isOnline: false,
      ),
      ChatModel(
        id: '6',
        name: 'Anna',
        avatarUrl: 'assets/images/user6.png',
        lastMessage: "It's Ok, thankyou",
        time: 'Yesterday',
        unreadCount: 0,
        isOnline: true,
      ),
    ];
  }

  @override
  Future<List<StoryModel>> getStories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      StoryModel(
        id: '1',
        name: 'Add story',
        avatarUrl: '', // Special case for "Add story"
        isViewed: false,
      ),
      StoryModel(
        id: '2',
        name: 'Carolina',
        avatarUrl: 'assets/images/story1.png',
        isViewed: false,
      ),
      StoryModel(
        id: '3',
        name: 'Jonathon',
        avatarUrl: 'assets/images/story2.png',
        isViewed: false,
      ),
      StoryModel(
        id: '4',
        name: 'Androw',
        avatarUrl: 'assets/images/story3.png',
        isViewed: false,
      ),
      StoryModel(
        id: '5',
        name: 'Paper',
        avatarUrl: 'assets/images/story4.png',
        isViewed: false,
      ),
      StoryModel(
        id: '6',
        name: 'Cral',
        avatarUrl: 'assets/images/story5.png',
        isViewed: true,
      ),
    ];
  }
}
