import '../../../auth/domain/repositories/auth_repository.dart';
import '../entities/booking_details.dart';
import '../repositories/booking_details_repository.dart';

/// Use case to get initial booking details
class GetInitialBookingDetails {
  final BookingDetailsRepository repository;
  final AuthRepository authRepository;

  const GetInitialBookingDetails(this.repository, this.authRepository);

  Future<BookingDetails> call(
    String carId,
    double price,
    String carName,
    String carImageUrl,
  ) async {
    final bookingDetails = await repository.getInitialBookingDetails(
      carId,
      price,
      carName,
      carImageUrl,
    );

    final userResult = await authRepository.getCurrentUser();

    return userResult.fold(
      (failure) => bookingDetails,
      (user) => bookingDetails.copyWith(
        fullName: '${user.firstName} ${user.lastName}',
        email: user.email,
        contact: user.phoneNumber,
      ),
    );
  }
}
