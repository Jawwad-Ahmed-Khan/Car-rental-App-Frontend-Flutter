import 'package:flutter/material.dart';
import '../../domain/entities/booking_details.dart';

/// Rental type selector with Hour/Day/Weekly/Monthly chips
class RentalTypeSelector extends StatelessWidget {
  final RentalType selectedType;
  final ValueChanged<RentalType> onTypeSelected;

  const RentalTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rental Date & Time',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildTypeChip(RentalType.hour, 'Hour'),
            const SizedBox(width: 12),
            _buildTypeChip(RentalType.day, 'Day'),
            const SizedBox(width: 12),
            _buildTypeChip(RentalType.weekly, 'Weekly'),
            const SizedBox(width: 12),
            _buildTypeChip(RentalType.monthly, 'Monthly'),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeChip(RentalType type, String label) {
    final isSelected = selectedType == type;
    return GestureDetector(
      onTap: () => onTypeSelected(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF21292B) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF21292B) : const Color(0xFFD7D7D7),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF5A5A5A),
          ),
        ),
      ),
    );
  }
}
