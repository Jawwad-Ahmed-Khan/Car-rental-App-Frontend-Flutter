import '../entities/booking_time.dart';

/// Repository interface for booking operations
abstract class BookingRepository {
  /// Validate the booking time selection
  Future<bool> validateBookingTime(BookingTime bookingTime);
  
  /// Save booking time selection
  Future<void> saveBookingTime(BookingTime bookingTime);
}
