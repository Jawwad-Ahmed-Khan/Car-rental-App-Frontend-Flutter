import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../data/datasources/booking_remote_data_source.dart';
import '../../data/models/booking_model.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_time.dart';
import '../../domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BookingRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Booking>> createBooking(Booking booking) async {
    if (await networkInfo.isConnected) {
      try {
        final bookingModel = BookingModel(
          vehicleId: booking.vehicleId,
          name: booking.name,
          email: booking.email,
          phone: booking.phone,
          cnic: booking.cnic,
          pickupDate: booking.pickupDate,
          returnDate: booking.returnDate,
          pickupLocation: booking.pickupLocation,
          returnLocation: booking.returnLocation,
          serviceType: booking.serviceType,
          priceModel: booking.priceModel,
        );

        final result = await remoteDataSource.createBooking(bookingModel);
        return Right(result);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(ServerFailure('No internet connection'));
    }
  }

  @override
  Future<bool> validateBookingTime(BookingTime bookingTime) async {
    // TODO: Implement actual validation logic (e.g., check availability with backend)
    return true;
  }

  @override
  Future<void> saveBookingTime(BookingTime bookingTime) async {
    // TODO: Implement actual save logic (e.g., save to local storage or backend)
    return;
  }
}
