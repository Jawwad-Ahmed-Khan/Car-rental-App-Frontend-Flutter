import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../di/injection_container.dart';
import '../../../auth/data/datasources/auth_local_datasource.dart';
import '../../data/datasources/payment_local_data_source.dart';
import '../../data/datasources/payment_remote_data_source.dart';
import '../../data/repositories/payment_repository_impl.dart';
import 'payment_event.dart';
import 'payment_state.dart';

/// BLoC for managing payment state
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepositoryImpl _repository;
  PaymentBloc()
    : _repository = PaymentRepositoryImpl(
        localDataSource: PaymentLocalDataSource(),
        remoteDataSource: PaymentRemoteDataSourceImpl(
          client: sl(),
          appConfig: sl(),
          authLocalDataSource: sl<AuthLocalDataSource>(),
        ),
      ),
      super(const PaymentInitial()) {
    on<LoadPaymentData>(_onLoadPaymentData);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<ConfirmPayment>(_onConfirmPayment);
  }

  Future<void> _onLoadPaymentData(
    LoadPaymentData event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentLoading());

    try {
      final paymentMethods = await _repository.getPaymentMethods();
      final savedCard = await _repository.getSavedCard();

      // Find the default selected payment method
      String? selectedId;
      for (final method in paymentMethods) {
        if (method.isSelected) {
          selectedId = method.id;
          break;
        }
      }

      emit(
        PaymentLoaded(
          paymentMethods: paymentMethods,
          savedCard: savedCard,
          selectedPaymentMethodId: selectedId,
          totalAmount: event.totalAmount,
        ),
      );
    } catch (e) {
      emit(PaymentError('Failed to load payment methods: $e'));
    }
  }

  void _onSelectPaymentMethod(
    SelectPaymentMethod event,
    Emitter<PaymentState> emit,
  ) {
    final currentState = state;
    if (currentState is PaymentLoaded) {
      // Update payment methods selection
      final updatedMethods = currentState.paymentMethods.map((method) {
        return method.copyWith(isSelected: method.id == event.paymentMethodId);
      }).toList();

      emit(
        currentState.copyWith(
          paymentMethods: updatedMethods,
          selectedPaymentMethodId: event.paymentMethodId,
        ),
      );
    }
  }

  Future<void> _onConfirmPayment(
    ConfirmPayment event,
    Emitter<PaymentState> emit,
  ) async {
    final currentState = state;
    if (currentState is PaymentLoaded) {
      if (currentState.selectedPaymentMethodId == null) {
        emit(const PaymentError('Please select a payment method'));
        emit(currentState);
        return;
      }

      emit(const PaymentProcessing());

      try {
        final paymentSuccess = await _repository.processPayment(
          bookingId: event.bookingId,
          paymentMethod: currentState.selectedPaymentMethodId!,
        );

        if (paymentSuccess) {
          emit(
            PaymentSuccess(
              bookingId: event.bookingId,
              paymentMethod: currentState.selectedPaymentMethodId!,
              amount: currentState.totalAmount,
            ),
          );
        } else {
          emit(const PaymentError('Payment failed. Please try again.'));
        }
      } catch (e) {
        emit(PaymentError('Payment processing failed: $e'));
      }
    }
  }
}
