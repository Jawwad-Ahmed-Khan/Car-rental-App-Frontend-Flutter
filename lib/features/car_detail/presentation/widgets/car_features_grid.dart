import 'package:flutter/material.dart';
import '../../domain/entities/car_feature.dart';
import 'car_feature_card.dart';

/// Grid displaying car features in 2x3 layout
class CarFeaturesGrid extends StatelessWidget {
  final List<CarFeature> features;

  const CarFeaturesGrid({
    super.key,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Car features',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.0,
            ),
            itemCount: features.length > 6 ? 6 : features.length,
            itemBuilder: (context, index) {
              return CarFeatureCard(feature: features[index]);
            },
          ),
        ],
      ),
    );
  }
}
