import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../themes/app_colors.dart';

/// Social login button widget
class SocialLoginButton extends StatelessWidget {
  final String iconAsset;
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const SocialLoginButton({
    super.key,
    required this.iconAsset,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        backgroundColor: backgroundColor ?? AppColors.white,
        foregroundColor: foregroundColor ?? AppColors.textPrimary,
        side: const BorderSide(color: AppColors.stroke, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Try to load SVG, fallback to Icon if not found
          _buildIcon(),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    // Check if asset is SVG
    if (iconAsset.endsWith('.svg')) {
      return SvgPicture.asset(
        iconAsset,
        width: 24,
        height: 24,
        // Fallback to placeholder if asset not found
        placeholderBuilder: (context) => const Icon(
          Icons.login,
          size: 24,
        ),
      );
    } else {
      // For PNG/JPG images
      return Image.asset(
        iconAsset,
        width: 24,
        height: 24,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.login,
            size: 24,
          );
        },
      );
    }
  }
}
