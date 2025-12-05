import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/confirmation_data.dart';
import 'confirmation_event.dart';
import 'confirmation_state.dart';

/// BLoC for managing confirmation state
class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  ConfirmationBloc() : super(const ConfirmationInitial()) {
    on<LoadConfirmationData>(_onLoadConfirmationData);
    on<ConfirmBooking>(_onConfirmBooking);
  }

  void _onLoadConfirmationData(
    LoadConfirmationData event,
    Emitter<ConfirmationState> emit,
  ) {
    emit(const ConfirmationLoading());

    try {
      final confirmationData = ConfirmationData.fromBookingAndPayment(
        userName: event.userName,
        pickupDate: event.pickupDate,
        returnDate: event.returnDate,
        pickupLocation: event.pickupLocation,
        returnLocation: event.returnLocation,
        carId: event.carId,
        carName: event.carName,
        carDescription: event.carDescription,
        carImageUrl: event.carImageUrl,
        carRating: event.carRating,
        reviewCount: event.reviewCount,
        amount: event.amount,
        serviceFee: event.serviceFee,
        paymentMethod: event.paymentMethod,
        paymentMethodIcon: event.paymentMethodIcon,
        pricePerDay: event.pricePerDay,
      );

      emit(ConfirmationLoaded(confirmationData: confirmationData));
    } catch (e) {
      emit(ConfirmationError('Failed to load confirmation data: $e'));
    }
  }

  Future<void> _onConfirmBooking(
    ConfirmBooking event,
    Emitter<ConfirmationState> emit,
  ) async {
    final currentState = state;
    if (currentState is ConfirmationLoaded) {
      emit(const ConfirmationProcessing());

      // Simulate processing delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Emit success with the confirmation data for navigation
      emit(
        ConfirmationSuccess(confirmationData: currentState.confirmationData),
      );
    }
  }
}
