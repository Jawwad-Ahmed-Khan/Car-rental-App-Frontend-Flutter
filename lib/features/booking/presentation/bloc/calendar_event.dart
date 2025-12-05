import 'package:equatable/equatable.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

/// Initialize the calendar with default values
class InitializeCalendar extends CalendarEvent {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final bool isSelectingEndDate;

  const InitializeCalendar({
    this.initialStartDate,
    this.initialEndDate,
    this.isSelectingEndDate = false,
  });

  @override
  List<Object?> get props => [
    initialStartDate,
    initialEndDate,
    isSelectingEndDate,
  ];
}

/// Update start time
class UpdateStartTime extends CalendarEvent {
  final int hour;
  final int minute;
  final bool isAm;

  const UpdateStartTime({
    required this.hour,
    required this.minute,
    required this.isAm,
  });

  @override
  List<Object?> get props => [hour, minute, isAm];
}

/// Update end time
class UpdateEndTime extends CalendarEvent {
  final int hour;
  final int minute;
  final bool isAm;

  const UpdateEndTime({
    required this.hour,
    required this.minute,
    required this.isAm,
  });

  @override
  List<Object?> get props => [hour, minute, isAm];
}

/// Navigate to previous month
class PreviousMonth extends CalendarEvent {
  const PreviousMonth();
}

/// Navigate to next month
class NextMonth extends CalendarEvent {
  const NextMonth();
}

/// Select a date (for range selection)
class SelectDate extends CalendarEvent {
  final DateTime date;

  const SelectDate(this.date);

  @override
  List<Object?> get props => [date];
}

/// Confirm the selection
class ConfirmSelection extends CalendarEvent {
  const ConfirmSelection();
}

/// Cancel the selection
class CancelSelection extends CalendarEvent {
  const CancelSelection();
}
