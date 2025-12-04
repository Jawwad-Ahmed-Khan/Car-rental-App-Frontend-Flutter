import 'package:flutter/material.dart';
import '../../domain/entities/filter_criteria.dart';

/// Widget for selecting car type (All Cars, Regular Cars, Luxury Cars)
class CarTypeSelector extends StatelessWidget {
  final CarType selectedType;
  final ValueChanged<CarType> onTypeSelected;

  const CarTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Type of Cars',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: CarType.values.map((type) {
              final isSelected = selectedType == type;
              return GestureDetector(
                onTap: () => onTypeSelected(type),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF21292B)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF21292B)
                          : const Color(0xFFD7D7D7),
                    ),
                  ),
                  child: Text(
                    _getTypeName(type),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _getTypeName(CarType type) {
    switch (type) {
      case CarType.allCars:
        return 'All Cars';
      case CarType.regularCars:
        return 'Regular Cars';
      case CarType.luxuryCars:
        return 'Luxury Cars';
    }
  }
}
