import 'package:equatable/equatable.dart';
import '../../domain/entities/payment_method.dart';

/// Base state for payment BLoC
abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

/// Loading state while fetching payment data
class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

/// Loaded state with payment methods and saved card
class PaymentLoaded extends PaymentState {
  final List<PaymentMethod> paymentMethods;
  final SavedCard? savedCard;
  final String? selectedPaymentMethodId;
  final double totalAmount;

  const PaymentLoaded({
    required this.paymentMethods,
    this.savedCard,
    this.selectedPaymentMethodId,
    required this.totalAmount,
  });

  @override
  List<Object?> get props => [
        paymentMethods,
        savedCard,
        selectedPaymentMethodId,
        totalAmount,
      ];

  PaymentLoaded copyWith({
    List<PaymentMethod>? paymentMethods,
    SavedCard? savedCard,
    String? selectedPaymentMethodId,
    double? totalAmount,
  }) {
    return PaymentLoaded(
      paymentMethods: paymentMethods ?? this.paymentMethods,
      savedCard: savedCard ?? this.savedCard,
      selectedPaymentMethodId:
          selectedPaymentMethodId ?? this.selectedPaymentMethodId,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}

/// Processing payment state
class PaymentProcessing extends PaymentState {
  const PaymentProcessing();
}

/// Payment success state
class PaymentSuccess extends PaymentState {
  const PaymentSuccess();
}

/// Payment error state
class PaymentError extends PaymentState {
  final String message;

  const PaymentError(this.message);

  @override
  List<Object?> get props => [message];
}
