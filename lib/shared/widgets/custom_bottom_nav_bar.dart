import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C), // Dark background from design
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, EvaIcons.home_outline, EvaIcons.home),
          _buildNavItem(1, EvaIcons.search_outline, EvaIcons.search),
          _buildNavItem(2, EvaIcons.message_square_outline, EvaIcons.message_square),
          _buildNavItem(3, EvaIcons.bulb_outline, EvaIcons.bulb),
          _buildNavItem(4, EvaIcons.person_outline, EvaIcons.person),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Icon(
          isSelected ? activeIcon : icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
