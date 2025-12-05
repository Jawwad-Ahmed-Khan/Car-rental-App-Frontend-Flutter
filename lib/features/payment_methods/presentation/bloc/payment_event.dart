import 'package:equatable/equatable.dart';

/// Base event for payment BLoC
abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load payment methods and saved card
class LoadPaymentData extends PaymentEvent {
  final double totalAmount;

  const LoadPaymentData({required this.totalAmount});

  @override
  List<Object?> get props => [totalAmount];
}

/// Event to select a payment method
class SelectPaymentMethod extends PaymentEvent {
  final String paymentMethodId;

  const SelectPaymentMethod(this.paymentMethodId);

  @override
  List<Object?> get props => [paymentMethodId];
}

/// Event to confirm and process payment
class ConfirmPayment extends PaymentEvent {
  final int bookingId;

  const ConfirmPayment({required this.bookingId});

  @override
  List<Object?> get props => [bookingId];
}
