import 'package:equatable/equatable.dart';
import '../../domain/entities/payment_result.dart';

/// Base state for payment states BLoC
abstract class PaymentStatesState extends Equatable {
  const PaymentStatesState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PaymentStatesInitial extends PaymentStatesState {
  const PaymentStatesInitial();
}

/// Loaded state with payment result
class PaymentStatesLoaded extends PaymentStatesState {
  final PaymentResult paymentResult;

  const PaymentStatesLoaded({required this.paymentResult});

  @override
  List<Object?> get props => [paymentResult];
}

/// Downloading receipt state
class PaymentStatesDownloading extends PaymentStatesState {
  const PaymentStatesDownloading();
}

/// Sharing receipt state
class PaymentStatesSharing extends PaymentStatesState {
  const PaymentStatesSharing();
}
