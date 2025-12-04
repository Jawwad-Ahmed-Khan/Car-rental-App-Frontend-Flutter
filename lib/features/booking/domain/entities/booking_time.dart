import 'package:equatable/equatable.dart';

/// Entity representing booking time selection
class BookingTime extends Equatable {
  final DateTime startTime;
  final DateTime endTime;
  final DateTime? startDate;
  final DateTime? endDate;

  const BookingTime({
    required this.startTime,
    required this.endTime,
    this.startDate,
    this.endDate,
  });

  /// Check if a date range is selected
  bool get hasDateRange => startDate != null && endDate != null;

  /// Default booking time with current date
  factory BookingTime.defaultTime() {
    final now = DateTime.now();
    return BookingTime(
      startTime: DateTime(now.year, now.month, now.day, 10, 30),
      endTime: DateTime(now.year, now.month, now.day, 17, 30),
      startDate: null,
      endDate: null,
    );
  }

  BookingTime copyWith({
    DateTime? startTime,
    DateTime? endTime,
    DateTime? startDate,
    DateTime? endDate,
    bool clearDateRange = false,
  }) {
    return BookingTime(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startDate: clearDateRange ? null : (startDate ?? this.startDate),
      endDate: clearDateRange ? null : (endDate ?? this.endDate),
    );
  }

  @override
  List<Object?> get props => [startTime, endTime, startDate, endDate];
}
