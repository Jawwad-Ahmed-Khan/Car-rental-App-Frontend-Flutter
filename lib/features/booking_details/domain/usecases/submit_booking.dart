import '../entities/booking_details.dart';
import '../repositories/booking_details_repository.dart';

/// Use case to submit booking
class SubmitBooking {
  final BookingDetailsRepository repository;

  const SubmitBooking(this.repository);

  Future<bool> call(BookingDetails booking) {
    return repository.submitBooking(booking);
  }
}
