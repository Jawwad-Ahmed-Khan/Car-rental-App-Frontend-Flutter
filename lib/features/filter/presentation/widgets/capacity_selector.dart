import 'package:flutter/material.dart';

/// Widget for selecting seating capacity
class CapacitySelector extends StatelessWidget {
  final int? selectedCapacity;
  final ValueChanged<int?> onCapacitySelected;

  const CapacitySelector({
    super.key,
    this.selectedCapacity,
    required this.onCapacitySelected,
  });

  static const List<int> capacities = [2, 4, 6, 8];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Siting Capacity',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: capacities.map((capacity) {
              final isSelected = selectedCapacity == capacity;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () => onCapacitySelected(
                    isSelected ? null : capacity,
                  ),
                  child: Container(
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF21292B)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF21292B)
                            : const Color(0xFFD7D7D7),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      capacity.toString(),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
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
}
