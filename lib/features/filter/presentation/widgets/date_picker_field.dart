import 'package:flutter/material.dart';
import '../../../booking/presentation/pages/date_time_picker_dialog.dart';

/// Widget for selecting pickup and drop date
class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final DateTime? endDate;
  final ValueChanged<DateTime?> onDateSelected;
  final ValueChanged<DateTime?>? onEndDateSelected;

  const DatePickerField({
    super.key,
    this.selectedDate,
    this.endDate,
    required this.onDateSelected,
    this.onEndDateSelected,
  });

  String _formatDateRange() {
    if (selectedDate == null) return 'Select Date';
    
    final startStr = _formatDate(selectedDate!);
    if (endDate != null && endDate != selectedDate) {
      final endStr = _formatDate(endDate!);
      return '$startStr - $endStr';
    }
    return startStr;
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Pick up and Drop Date',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () => _showDatePicker(context),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Color(0xFF767676),
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDateRange(),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    // Use our custom DateTimePickerDialog
    final result = await DateTimePickerDialog.show(context);
    
    if (result != null) {
      // Return the start date
      if (result.startDate != null) {
        onDateSelected(result.startDate);
      }
      // Return the end date if callback provided
      if (onEndDateSelected != null && result.endDate != null) {
        onEndDateSelected!(result.endDate);
      }
    }
  }
}
