import 'package:flutter/material.dart';
import '../../domain/entities/filter_criteria.dart';

/// Widget for selecting fuel type
class FuelTypeSelector extends StatelessWidget {
  final FuelType? selectedFuelType;
  final ValueChanged<FuelType?> onFuelTypeSelected;

  const FuelTypeSelector({
    super.key,
    this.selectedFuelType,
    required this.onFuelTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fuel Type',
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
            children: FuelType.values.map((type) {
              final isSelected = selectedFuelType == type;
              return GestureDetector(
                onTap: () => onFuelTypeSelected(
                  isSelected ? null : type,
                ),
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
                    _getFuelTypeName(type),
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

  String _getFuelTypeName(FuelType type) {
    switch (type) {
      case FuelType.electric:
        return 'Electric';
      case FuelType.petrol:
        return 'Petrol';
      case FuelType.diesel:
        return 'Diesel';
      case FuelType.hybrid:
        return 'Hybrid';
    }
  }
}
