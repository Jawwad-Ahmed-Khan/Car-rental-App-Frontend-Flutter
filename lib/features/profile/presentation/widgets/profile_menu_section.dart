import 'package:flutter/material.dart';
import '../../../../shared/themes/app_colors.dart';

/// Section widget with title and list of menu items
class ProfileMenuSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ProfileMenuSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}
