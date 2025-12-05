import 'package:flutter/material.dart';
import '../../domain/entities/booking_details.dart';

/// Gender selector with Male/Female/Others chips
class GenderSelector extends StatelessWidget {
  final Gender selectedGender;
  final ValueChanged<Gender> onGenderSelected;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
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
            _buildGenderChip(Gender.male, 'Male', Icons.male),
            const SizedBox(width: 12),
            _buildGenderChip(Gender.female, 'Female', Icons.female),
            const SizedBox(width: 12),
            _buildGenderChip(Gender.others, 'Others', Icons.transgender),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderChip(Gender gender, String label, IconData icon) {
    final isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () => onGenderSelected(gender),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF21292B) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF21292B) : const Color(0xFFD7D7D7),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : const Color(0xFF5A5A5A),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF5A5A5A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
