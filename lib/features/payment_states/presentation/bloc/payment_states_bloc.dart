import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/payment_result.dart';
import 'payment_states_event.dart';
import 'payment_states_state.dart';

/// BLoC for managing payment states
class PaymentStatesBloc extends Bloc<PaymentStatesEvent, PaymentStatesState> {
  PaymentStatesBloc() : super(const PaymentStatesInitial()) {
    on<LoadPaymentResult>(_onLoadPaymentResult);
    on<DownloadReceipt>(_onDownloadReceipt);
    on<ShareReceipt>(_onShareReceipt);
  }

  void _onLoadPaymentResult(
    LoadPaymentResult event,
    Emitter<PaymentStatesState> emit,
  ) {
    final paymentResult = PaymentResult.fromConfirmation(
      carModel: event.carModel,
      pickupDate: event.pickupDate,
      returnDate: event.returnDate,
      userName: event.userName,
      transactionId: event.transactionId,
      paymentMethod: event.paymentMethod,
      amount: event.amount,
      serviceFee: event.serviceFee,
      totalAmount: event.totalAmount,
      pricePerDay: event.pricePerDay,
    );

    emit(PaymentStatesLoaded(paymentResult: paymentResult));
  }

  Future<void> _onDownloadReceipt(
    DownloadReceipt event,
    Emitter<PaymentStatesState> emit,
  ) async {
    final currentState = state;
    if (currentState is PaymentStatesLoaded) {
      emit(const PaymentStatesDownloading());
      // Simulate download delay
      await Future.delayed(const Duration(seconds: 1));
      emit(currentState);
    }
  }

  Future<void> _onShareReceipt(
    ShareReceipt event,
    Emitter<PaymentStatesState> emit,
  ) async {
    final currentState = state;
    if (currentState is PaymentStatesLoaded) {
      emit(const PaymentStatesSharing());
      // Simulate share delay
      await Future.delayed(const Duration(seconds: 1));
      emit(currentState);
    }
  }
}
