import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/app_colors.dart';

/// App logo widget
class AppLogo extends StatelessWidget {
  final double height;

  const AppLogo({
    super.key,
    this.height = 36,
  });

  @override
  Widget build(BuildContext context) {
    // Logo icon
    return SvgPicture.asset(
      'assets/images/blacklogo.svg',
      height: height,
      width: height,
      placeholderBuilder: (context) => Container(
        height: height,
        width: height,
        decoration: BoxDecoration(
          color: AppColors.buttons,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.directions_car, color: Colors.white),
      ),
    );
  }
}
