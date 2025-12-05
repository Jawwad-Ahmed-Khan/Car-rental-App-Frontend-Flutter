import 'package:flutter/material.dart';
import '../../../../shared/themes/app_colors.dart';

/// Reusable profile menu item widget with icon, title, and chevron
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.stroke, width: 1),
              ),
              child: Icon(
                icon,
                size: 20,
                color: const Color(0xFF767676),
              ),
            ),
            const SizedBox(width: 16),
            // Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            // Trailing (chevron by default)
            trailing ??
                const Icon(
                  Icons.chevron_right,
                  size: 24,
                  color: AppColors.textSecondary,
                ),
          ],
        ),
      ),
    );
  }
}
