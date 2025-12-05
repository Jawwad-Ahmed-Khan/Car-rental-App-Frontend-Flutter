import 'package:equatable/equatable.dart';

/// Base event for confirmation BLoC
abstract class ConfirmationEvent extends Equatable {
  const ConfirmationEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load confirmation data
class LoadConfirmationData extends ConfirmationEvent {
  final String userName;
  final DateTime pickupDate;
  final DateTime returnDate;
  final String pickupLocation;
  final String returnLocation;
  final String carId;
  final String carName;
  final String carDescription;
  final String carImageUrl;
  final double carRating;
  final int reviewCount;
  final double amount;
  final double serviceFee;
  final String paymentMethod;
  final String paymentMethodIcon;
  final double pricePerDay;

  const LoadConfirmationData({
    required this.userName,
    required this.pickupDate,
    required this.returnDate,
    required this.pickupLocation,
    required this.returnLocation,
    required this.carId,
    required this.carName,
    required this.carDescription,
    required this.carImageUrl,
    required this.carRating,
    required this.reviewCount,
    required this.amount,
    required this.serviceFee,
    required this.paymentMethod,
    required this.paymentMethodIcon,
    this.pricePerDay = 0.0,
  });

  @override
  List<Object?> get props => [
    userName,
    pickupDate,
    returnDate,
    pickupLocation,
    returnLocation,
    carId,
    carName,
    carDescription,
    carImageUrl,
    carRating,
    reviewCount,
    amount,
    serviceFee,
    paymentMethod,
    paymentMethodIcon,
    pricePerDay,
  ];
}

/// Event to confirm the booking
class ConfirmBooking extends ConfirmationEvent {
  const ConfirmBooking();
}
