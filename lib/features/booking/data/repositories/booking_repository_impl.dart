import '../../domain/entities/booking_time.dart';
import '../../domain/repositories/booking_repository.dart';

/// Implementation of BookingRepository
class BookingRepositoryImpl implements BookingRepository {
  BookingTime? _savedBookingTime;

  @override
  Future<bool> validateBookingTime(BookingTime bookingTime) async {
    // Validate that end time is after start time
    if (bookingTime.endTime.isBefore(bookingTime.startTime)) {
      return false;
    }
    
    // Validate date range if selected
    if (bookingTime.startDate != null && bookingTime.endDate != null) {
      if (bookingTime.endDate!.isBefore(bookingTime.startDate!)) {
        return false;
      }
    }
    
    return true;
  }

  @override
  Future<void> saveBookingTime(BookingTime bookingTime) async {
    _savedBookingTime = bookingTime;
  }
  
  /// Get the current saved booking time
  BookingTime? get savedBookingTime => _savedBookingTime;
}
