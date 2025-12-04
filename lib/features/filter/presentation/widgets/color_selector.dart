import 'package:flutter/material.dart';
import '../../domain/entities/filter_criteria.dart';

/// Widget for selecting car color
class ColorSelector extends StatelessWidget {
  final CarColor? selectedColor;
  final ValueChanged<CarColor?> onColorSelected;

  const ColorSelector({
    super.key,
    this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Colors',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to see all colors
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Color(0xFF7F7F7F),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: CarColor.values.map((color) {
              final isSelected = selectedColor == color;
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () => onColorSelected(
                    isSelected ? null : color,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: _getColorValue(color),
                          shape: BoxShape.circle,
                          border: color == CarColor.white
                              ? Border.all(color: const Color(0xFFD7D7D7))
                              : null,
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check,
                                size: 18,
                                color: color == CarColor.white
                                    ? Colors.black
                                    : Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getColorName(color),
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          color: Color(0xFF7F7F7F),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getColorValue(CarColor color) {
    switch (color) {
      case CarColor.white:
        return Colors.white;
      case CarColor.gray:
        return const Color(0xFFD7D7D7);
      case CarColor.blue:
        return const Color(0xFF2196F3);
      case CarColor.black:
        return Colors.black;
    }
  }

  String _getColorName(CarColor color) {
    switch (color) {
      case CarColor.white:
        return 'White';
      case CarColor.gray:
        return 'Gray';
      case CarColor.blue:
        return 'Blue';
      case CarColor.black:
        return 'Black';
    }
  }
}
