import 'package:equatable/equatable.dart';

/// Base event for payment states BLoC
abstract class PaymentStatesEvent extends Equatable {
  const PaymentStatesEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load payment result data
class LoadPaymentResult extends PaymentStatesEvent {
  final String carModel;
  final DateTime pickupDate;
  final DateTime returnDate;
  final String userName;
  final String transactionId;
  final String paymentMethod;
  final double amount;
  final double serviceFee;
  final double totalAmount;
  final double pricePerDay;

  const LoadPaymentResult({
    required this.carModel,
    required this.pickupDate,
    required this.returnDate,
    required this.userName,
    required this.transactionId,
    required this.paymentMethod,
    required this.amount,
    required this.serviceFee,
    required this.totalAmount,
    this.pricePerDay = 0.0,
  });

  @override
  List<Object?> get props => [
    carModel,
    pickupDate,
    returnDate,
    userName,
    transactionId,
    paymentMethod,
    amount,
    serviceFee,
    totalAmount,
    pricePerDay,
  ];
}

/// Event to download receipt
class DownloadReceipt extends PaymentStatesEvent {
  const DownloadReceipt();
}

/// Event to share receipt
class ShareReceipt extends PaymentStatesEvent {
  const ShareReceipt();
}

/// Event to go back to home
class GoBackToHome extends PaymentStatesEvent {
  const GoBackToHome();
}
