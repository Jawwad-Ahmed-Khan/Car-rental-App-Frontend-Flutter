import 'package:flutter/material.dart';
import '../../../../shared/themes/app_colors.dart';

/// Profile page app bar with back button, title, and menu button
class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;

  const ProfileAppBar({
    super.key,
    this.onBackPressed,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.stroke, width: 1),
          ),
          child: const Icon(
            Icons.chevron_left,
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Profile',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.stroke, width: 1),
            ),
            child: const Icon(
              Icons.more_horiz,
              color: AppColors.textPrimary,
              size: 20,
            ),
          ),
          onPressed: onMenuPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
