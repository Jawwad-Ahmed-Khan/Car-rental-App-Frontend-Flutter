import 'package:equatable/equatable.dart';

/// Entity representing payment result data
class PaymentResult extends Equatable {
  // Booking info
  final String carModel;
  final DateTime pickupDate;
  final DateTime returnDate;
  final String userName;

  // Transaction info
  final String transactionId;
  final DateTime transactionDate;
  final String paymentMethod;
  final String maskedCardNumber;

  // Amount info
  final double amount;
  final double serviceFee;
  final double tax;
  final double totalAmount;
  final double pricePerDay;

  const PaymentResult({
    required this.carModel,
    required this.pickupDate,
    required this.returnDate,
    required this.userName,
    required this.transactionId,
    required this.transactionDate,
    required this.paymentMethod,
    required this.maskedCardNumber,
    required this.amount,
    required this.serviceFee,
    required this.tax,
    required this.totalAmount,
    this.pricePerDay = 0.0,
  });

  /// Create payment result from confirmation data
  factory PaymentResult.fromConfirmation({
    required String carModel,
    required DateTime pickupDate,
    required DateTime returnDate,
    required String userName,
    required String transactionId,
    required String paymentMethod,
    required double amount,
    required double serviceFee,
    required double totalAmount,
    double pricePerDay = 0.0,
  }) {
    return PaymentResult(
      carModel: carModel,
      pickupDate: pickupDate,
      returnDate: returnDate,
      userName: userName,
      transactionId: transactionId,
      transactionDate: DateTime.now(),
      paymentMethod: paymentMethod,
      maskedCardNumber: paymentMethod.toLowerCase() == 'cash'
          ? ''
          : '123 *** *** ***225', // Mock card number for now
      amount: amount,
      serviceFee: serviceFee,
      tax: 0.0,
      totalAmount: totalAmount,
      pricePerDay: pricePerDay,
    );
  }

  @override
  List<Object?> get props => [
    carModel,
    pickupDate,
    returnDate,
    userName,
    transactionId,
    transactionDate,
    paymentMethod,
    maskedCardNumber,
    amount,
    serviceFee,
    tax,
    totalAmount,
    pricePerDay,
  ];
}
