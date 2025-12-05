import 'package:flutter/material.dart';

/// Section displaying pickup and return dates with tap handlers
class RentalDateSection extends StatelessWidget {
  final DateTime? pickupDate;
  final DateTime? returnDate;
  final VoidCallback onPickupDateTap;
  final VoidCallback onReturnDateTap;

  const RentalDateSection({
    super.key,
    this.pickupDate,
    this.returnDate,
    required this.onPickupDateTap,
    required this.onReturnDateTap,
  });

  static const List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select date';
    return '${date.day}/ ${_months[date.month - 1]} /${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildDateCard(
            label: 'Pick up Date',
            date: pickupDate,
            onTap: onPickupDateTap,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildDateCard(
            label: 'Return Date',
            date: returnDate,
            onTap: onReturnDateTap,
          ),
        ),
      ],
    );
  }

  Widget _buildDateCard({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFD7D7D7)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: Color(0xFF5A5A5A),
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDate(date),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5A5A5A),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
