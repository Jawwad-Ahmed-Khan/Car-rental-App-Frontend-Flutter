import 'package:flutter/material.dart';

class CarSection extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAllPressed;
  final Widget child;

  const CarSection({
    super.key,
    required this.title,
    this.onViewAllPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: onViewAllPressed,
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7F7F7F),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        child,
      ],
    );
  }
}
