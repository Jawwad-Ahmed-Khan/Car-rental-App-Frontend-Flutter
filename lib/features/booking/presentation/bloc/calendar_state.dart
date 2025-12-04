import 'package:equatable/equatable.dart';
import '../../domain/entities/booking_time.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class CalendarInitial extends CalendarState {
  const CalendarInitial();
}

/// Calendar loaded with data
class CalendarLoaded extends CalendarState {
  final DateTime displayMonth;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final bool isSelectingEndDate;

  const CalendarLoaded({
    required this.displayMonth,
    required this.startTime,
    required this.endTime,
    this.rangeStart,
    this.rangeEnd,
    this.isSelectingEndDate = false,
  });

  /// Get the booking time from current state
  BookingTime get bookingTime => BookingTime(
        startTime: startTime,
        endTime: endTime,
        startDate: rangeStart,
        endDate: rangeEnd,
      );

  CalendarLoaded copyWith({
    DateTime? displayMonth,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? rangeStart,
    DateTime? rangeEnd,
    bool? isSelectingEndDate,
    bool clearRange = false,
  }) {
    return CalendarLoaded(
      displayMonth: displayMonth ?? this.displayMonth,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      rangeStart: clearRange ? null : (rangeStart ?? this.rangeStart),
      rangeEnd: clearRange ? null : (rangeEnd ?? this.rangeEnd),
      isSelectingEndDate: isSelectingEndDate ?? this.isSelectingEndDate,
    );
  }

  @override
  List<Object?> get props => [
        displayMonth,
        startTime,
        endTime,
        rangeStart,
        rangeEnd,
        isSelectingEndDate,
      ];
}

/// Selection confirmed
class CalendarConfirmed extends CalendarState {
  final BookingTime bookingTime;

  const CalendarConfirmed(this.bookingTime);

  @override
  List<Object?> get props => [bookingTime];
}

/// Selection cancelled
class CalendarCancelled extends CalendarState {
  const CalendarCancelled();
}
