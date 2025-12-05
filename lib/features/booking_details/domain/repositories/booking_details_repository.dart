import '../entities/booking_details.dart';

/// Repository interface for booking operations
abstract class BookingDetailsRepository {
  /// Get initial booking details for a car
  Future<BookingDetails> getInitialBookingDetails(String carId, double price);

  /// Submit booking details
  Future<bool> submitBooking(BookingDetails booking);
}
