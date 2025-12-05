import 'package:flutter/material.dart';

/// Custom app bar for Car Details page
class CarDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;

  const CarDetailAppBar({
    super.key,
    this.onBackPressed,
    this.onMenuPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD7D7D7)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 16,
            color: Colors.black,
          ),
        ),
      ),
      centerTitle: true,
      title: const Text(
        'Car Details',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: onMenuPressed,
          icon: const Icon(
            Icons.more_horiz,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
