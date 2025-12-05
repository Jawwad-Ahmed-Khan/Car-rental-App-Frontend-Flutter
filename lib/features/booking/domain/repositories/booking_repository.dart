import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/booking.dart';
import '../entities/booking_time.dart';

abstract class BookingRepository {
  Future<Either<Failure, Booking>> createBooking(Booking booking);
  Future<bool> validateBookingTime(BookingTime bookingTime);
  Future<void> saveBookingTime(BookingTime bookingTime);
}
