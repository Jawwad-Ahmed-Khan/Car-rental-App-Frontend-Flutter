import 'package:flutter/material.dart';

/// Car feature entity representing a single feature of the car
class CarFeature {
  final IconData icon;
  final String title;
  final String value;

  const CarFeature({
    required this.icon,
    required this.title,
    required this.value,
  });
}
