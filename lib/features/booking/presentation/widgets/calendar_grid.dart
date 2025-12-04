import 'package:flutter/material.dart';

/// Widget displaying the calendar grid with date selection
class CalendarGrid extends StatelessWidget {
  final DateTime displayMonth;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarGrid({
    super.key,
    required this.displayMonth,
    this.rangeStart,
    this.rangeEnd,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Day headers
          _buildDayHeaders(),
          const SizedBox(height: 10),
          // Calendar grid
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildDayHeaders() {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days.map((day) {
        return SizedBox(
          width: 36,
          child: Text(
            day,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(displayMonth.year, displayMonth.month, 1);
    final lastDayOfMonth = DateTime(displayMonth.year, displayMonth.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final startingWeekday = firstDayOfMonth.weekday % 7; // 0 = Sunday

    final today = DateTime.now();
    final isCurrentMonth = displayMonth.year == today.year && 
                           displayMonth.month == today.month;

    List<Widget> rows = [];
    List<Widget> currentRow = [];

    // Add empty cells for days before the first day of the month
    for (int i = 0; i < startingWeekday; i++) {
      currentRow.add(_buildEmptyCell());
    }

    // Add days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(displayMonth.year, displayMonth.month, day);
      final isPast = isCurrentMonth && day < today.day;
      
      currentRow.add(_buildDayCell(date, isPast));

      if (currentRow.length == 7) {
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: currentRow,
        ));
        currentRow = [];
      }
    }

    // Add remaining empty cells
    if (currentRow.isNotEmpty) {
      while (currentRow.length < 7) {
        currentRow.add(_buildEmptyCell());
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: currentRow,
      ));
    }

    return Column(
      children: rows.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: row,
        );
      }).toList(),
    );
  }

  Widget _buildEmptyCell() {
    return const SizedBox(width: 36, height: 36);
  }

  Widget _buildDayCell(DateTime date, bool isPast) {
    final isRangeStart = rangeStart != null && _isSameDay(date, rangeStart!);
    final isRangeEnd = rangeEnd != null && _isSameDay(date, rangeEnd!);
    final isInRange = _isInRange(date);
    final isSelected = isRangeStart || isRangeEnd;

    Color backgroundColor = Colors.transparent;
    Color textColor = isPast ? const Color(0xFFD7D7D7) : Colors.black;
    BorderRadius borderRadius = BorderRadius.circular(18);

    if (isSelected) {
      backgroundColor = const Color(0xFF21292B);
      textColor = Colors.white;
    } else if (isInRange) {
      backgroundColor = const Color(0xFFEDEDED);
      borderRadius = BorderRadius.zero;
    }

    // Adjust border radius for range
    if (isRangeStart && rangeEnd != null) {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(18),
        bottomLeft: Radius.circular(18),
      );
    } else if (isRangeEnd && rangeStart != null) {
      borderRadius = const BorderRadius.only(
        topRight: Radius.circular(18),
        bottomRight: Radius.circular(18),
      );
    }

    return GestureDetector(
      onTap: isPast ? null : () => onDateSelected(date),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        alignment: Alignment.center,
        child: Text(
          date.day.toString(),
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isInRange(DateTime date) {
    if (rangeStart == null || rangeEnd == null) return false;
    return date.isAfter(rangeStart!) && date.isBefore(rangeEnd!);
  }
}
