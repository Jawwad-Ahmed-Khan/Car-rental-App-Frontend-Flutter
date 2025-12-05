import '../../domain/entities/booking_details.dart';
import '../../domain/repositories/booking_details_repository.dart';
import '../datasources/booking_details_local_data_source.dart';

/// Implementation of BookingDetailsRepository
class BookingDetailsRepositoryImpl implements BookingDetailsRepository {
  final BookingDetailsLocalDataSource localDataSource;

  const BookingDetailsRepositoryImpl({required this.localDataSource});

  @override
  Future<BookingDetails> getInitialBookingDetails(
    String carId,
    double price,
    String carName,
    String carImageUrl,
  ) async {
    return localDataSource.getInitialBookingDetails(
      carId,
      price,
      carName,
      carImageUrl,
    );
  }

  @override
  Future<bool> submitBooking(BookingDetails booking) async {
    return localDataSource.submitBooking(booking);
  }
}
