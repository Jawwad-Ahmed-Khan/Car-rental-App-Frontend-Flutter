import '../entities/booking_time.dart';
import '../repositories/booking_repository.dart';

/// Use case for selecting booking time
class SelectBookingTime {
  final BookingRepository repository;

  SelectBookingTime(this.repository);

  Future<bool> call(BookingTime bookingTime) async {
    // Validate the booking time
    final isValid = await repository.validateBookingTime(bookingTime);
    if (isValid) {
      await repository.saveBookingTime(bookingTime);
    }
    return isValid;
  }
}
