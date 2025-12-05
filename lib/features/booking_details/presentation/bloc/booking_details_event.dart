import 'package:equatable/equatable.dart';
import '../../domain/entities/booking_details.dart';

/// Base event for booking details
abstract class BookingDetailsEvent extends Equatable {
  const BookingDetailsEvent();

  @override
  List<Object?> get props => [];
}

/// Initialize booking details
class InitializeBookingDetails extends BookingDetailsEvent {
  final String carId;
  final double price;

  const InitializeBookingDetails({
    required this.carId,
    required this.price,
  });

  @override
  List<Object?> get props => [carId, price];
}

/// Update full name field
class UpdateFullName extends BookingDetailsEvent {
  final String fullName;

  const UpdateFullName(this.fullName);

  @override
  List<Object?> get props => [fullName];
}

/// Update email field
class UpdateEmail extends BookingDetailsEvent {
  final String email;

  const UpdateEmail(this.email);

  @override
  List<Object?> get props => [email];
}

/// Update contact field
class UpdateContact extends BookingDetailsEvent {
  final String contact;

  const UpdateContact(this.contact);

  @override
  List<Object?> get props => [contact];
}

/// Select gender
class SelectGender extends BookingDetailsEvent {
  final Gender gender;

  const SelectGender(this.gender);

  @override
  List<Object?> get props => [gender];
}

/// Select rental type
class SelectRentalType extends BookingDetailsEvent {
  final RentalType rentalType;

  const SelectRentalType(this.rentalType);

  @override
  List<Object?> get props => [rentalType];
}

/// Select pickup date
class SelectPickupDate extends BookingDetailsEvent {
  final DateTime date;

  const SelectPickupDate(this.date);

  @override
  List<Object?> get props => [date];
}

/// Select return date
class SelectReturnDate extends BookingDetailsEvent {
  final DateTime date;

  const SelectReturnDate(this.date);

  @override
  List<Object?> get props => [date];
}

/// Toggle book with driver option
class ToggleBookWithDriver extends BookingDetailsEvent {
  const ToggleBookWithDriver();
}

/// Submit booking
class SubmitBookingEvent extends BookingDetailsEvent {
  const SubmitBookingEvent();
}
