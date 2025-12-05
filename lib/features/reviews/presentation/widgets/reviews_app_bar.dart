import 'package:flutter/material.dart';

/// App bar for the Reviews page
class ReviewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onMorePressed;

  const ReviewsAppBar({
    super.key,
    this.onBackPressed,
    this.onMorePressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD7D7D7)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 24,
          ),
        ),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Reviews',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: 'Roboto',
        ),
      ),
      actions: [
        IconButton(
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD7D7D7)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.more_horiz,
              color: Colors.black,
              size: 20,
            ),
          ),
          onPressed: onMorePressed,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
