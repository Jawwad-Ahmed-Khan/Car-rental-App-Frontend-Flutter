import 'package:equatable/equatable.dart';

/// Entity representing all confirmation data
class ConfirmationData extends Equatable {
  // Booking Information
  final String bookingId;
  final String userName;
  final DateTime pickupDate;
  final DateTime returnDate;
  final String pickupLocation;
  final String returnLocation;

  // Car Information
  final String carId;
  final String carName;
  final String carDescription;
  final String carImageUrl;
  final double carRating;
  final int reviewCount;

  // Payment Information
  final String transactionId;
  final double amount;
  final double serviceFee;
  final double totalAmount;
  final String paymentMethod;
  final String paymentMethodIcon;
  final double pricePerDay;

  const ConfirmationData({
    required this.bookingId,
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
    required this.transactionId,
    required this.amount,
    required this.serviceFee,
    required this.totalAmount,
    required this.paymentMethod,
    required this.paymentMethodIcon,
    this.pricePerDay = 0.0,
  });

  /// Create confirmation data from booking and payment information
  factory ConfirmationData.fromBookingAndPayment({
    required String userName,
    required DateTime pickupDate,
    required DateTime returnDate,
    required String pickupLocation,
    required String returnLocation,
    required String carId,
    required String carName,
    required String carDescription,
    required String carImageUrl,
    required double carRating,
    required int reviewCount,
    required double amount,
    required double serviceFee,
    required String paymentMethod,
    required String paymentMethodIcon,
    double pricePerDay = 0.0,
  }) {
    // Generate booking ID
    final bookingId = _generateBookingId();
    // Generate transaction ID
    final transactionId = _generateTransactionId();

    return ConfirmationData(
      bookingId: bookingId,
      userName: userName,
      pickupDate: pickupDate,
      returnDate: returnDate,
      pickupLocation: pickupLocation,
      returnLocation: returnLocation,
      carId: carId,
      carName: carName,
      carDescription: carDescription,
      carImageUrl: carImageUrl,
      carRating: carRating,
      reviewCount: reviewCount,
      transactionId: transactionId,
      amount: amount,
      serviceFee: serviceFee,
      totalAmount: amount + serviceFee,
      paymentMethod: paymentMethod,
      paymentMethodIcon: paymentMethodIcon,
      pricePerDay: pricePerDay,
    );
  }

  static String _generateBookingId() {
    final random = DateTime.now().millisecondsSinceEpoch % 100000;
    return random.toString().padLeft(5, '0');
  }

  static String _generateTransactionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '#${timestamp.toRadixString(36).toUpperCase()}';
  }

  @override
  List<Object?> get props => [
    bookingId,
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
    transactionId,
    amount,
    serviceFee,
    totalAmount,
    paymentMethod,
    paymentMethodIcon,
    pricePerDay,
  ];
}
