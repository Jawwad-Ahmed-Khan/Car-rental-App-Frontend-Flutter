import 'package:flutter/material.dart';
import '../../domain/entities/filter_criteria.dart';

/// Widget for selecting rental time duration
class RentalTimeChips extends StatelessWidget {
  final RentalDuration selectedDuration;
  final ValueChanged<RentalDuration> onDurationSelected;

  const RentalTimeChips({
    super.key,
    required this.selectedDuration,
    required this.onDurationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rental Time',
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
            children: RentalDuration.values.map((duration) {
              final isSelected = selectedDuration == duration;
              return GestureDetector(
                onTap: () => onDurationSelected(duration),
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
                    _getDurationName(duration),
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

  String _getDurationName(RentalDuration duration) {
    switch (duration) {
      case RentalDuration.hour:
        return 'Hour';
      case RentalDuration.day:
        return 'Day';
      case RentalDuration.weekly:
        return 'Weekly';
      case RentalDuration.monthly:
        return 'Monthly';
    }
  }
}
