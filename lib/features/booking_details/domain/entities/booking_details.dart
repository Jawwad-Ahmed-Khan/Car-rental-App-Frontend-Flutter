import 'package:equatable/equatable.dart';

/// Enum for gender selection
enum Gender { male, female, others }

/// Enum for rental type selection
enum RentalType { hour, day, weekly, monthly }

/// Entity representing booking details form data
class BookingDetails extends Equatable {
  final String fullName;
  final String email;
  final String contact;
  final Gender gender;
  final RentalType rentalType;
  final DateTime? pickupDate;
  final DateTime? returnDate;
  final String location;
  final double totalPrice;
  final bool bookWithDriver;
  final double pricePerDay;
  final String carId;

  const BookingDetails({
    this.fullName = '',
    this.email = '',
    this.contact = '',
    this.gender = Gender.male,
    this.rentalType = RentalType.day,
    this.pickupDate,
    this.returnDate,
    this.location = '',
    this.totalPrice = 0.0,
    this.pricePerDay = 0.0,
    this.bookWithDriver = false,
    this.carId = '',
  });

  /// Check if form is valid
  bool get isValid =>
      fullName.isNotEmpty && email.isNotEmpty && contact.isNotEmpty;

  /// Calculate number of rental days
  int get rentalDays {
    if (pickupDate == null || returnDate == null) return 0;
    final days = returnDate!.difference(pickupDate!).inDays;
    return days < 1 ? 1 : days; // Minimum 1 day
  }

  BookingDetails copyWith({
    String? fullName,
    String? email,
    String? contact,
    Gender? gender,
    RentalType? rentalType,
    DateTime? pickupDate,
    DateTime? returnDate,
    String? location,
    double? totalPrice,
    double? pricePerDay,
    bool? bookWithDriver,
    String? carId,
  }) {
    return BookingDetails(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      contact: contact ?? this.contact,
      gender: gender ?? this.gender,
      rentalType: rentalType ?? this.rentalType,
      pickupDate: pickupDate ?? this.pickupDate,
      returnDate: returnDate ?? this.returnDate,
      location: location ?? this.location,
      totalPrice: totalPrice ?? this.totalPrice,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      bookWithDriver: bookWithDriver ?? this.bookWithDriver,
      carId: carId ?? this.carId,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        contact,
        gender,
        rentalType,
        pickupDate,
        returnDate,
        location,
        totalPrice,
        pricePerDay,
        bookWithDriver,
        carId,
      ];
}
