import 'package:flutter/material.dart';

/// Custom app bar for notification page
class NotificationAppBar extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onMorePressed;

  const NotificationAppBar({
    super.key,
    this.onBackPressed,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          GestureDetector(
            onTap: onBackPressed ?? () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFD7D7D7)),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Colors.black,
              ),
            ),
          ),
          // Title
          const Text(
            'Notification',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
          ),
          // More options button
          GestureDetector(
            onTap: onMorePressed,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFD7D7D7)),
              ),
              child: const Icon(
                Icons.more_horiz,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
