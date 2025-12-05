import 'package:flutter/material.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../search/presentation/pages/search_page.dart';
import '../../../chat/presentation/pages/chat_page.dart';
import '../../../chatbot/presentation/pages/chatbot_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const ChatPage(),
    const ChatbotPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allows body to go behind the floating nav bar
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
