import 'package:flutter/material.dart';
import 'custom_avatar.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
          onPressed: () {
            // Handle back navigation if needed, or just pop
             if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomAvatar(
            imageUrl: 'assets/images/user_avatar.png', // Replace with actual user avatar
            radius: 20,
          ),
          const SizedBox(width: 10),
          const Text(
            'Chats',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
