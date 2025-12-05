import 'package:flutter/material.dart';
import '../../domain/entities/car_feature.dart';

/// Single feature card widget
class CarFeatureCard extends StatelessWidget {
  final CarFeature feature;

  const CarFeatureCard({
    super.key,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD7D7D7)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            feature.icon,
            size: 24,
            color: const Color(0xFF767676),
          ),
          const SizedBox(height: 12),
          Text(
            feature.title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF7F7F7F),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            feature.value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
