import '../entities/booking_details.dart';
import '../repositories/booking_details_repository.dart';

/// Use case to get initial booking details
class GetInitialBookingDetails {
  final BookingDetailsRepository repository;

  const GetInitialBookingDetails(this.repository);

  Future<BookingDetails> call(String carId, double price) {
    return repository.getInitialBookingDetails(carId, price);
  }
}
