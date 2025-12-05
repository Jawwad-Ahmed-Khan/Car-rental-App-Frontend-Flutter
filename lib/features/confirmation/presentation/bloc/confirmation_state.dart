import 'package:equatable/equatable.dart';
import '../../domain/entities/confirmation_data.dart';

/// Base state for confirmation BLoC
abstract class ConfirmationState extends Equatable {
  const ConfirmationState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ConfirmationInitial extends ConfirmationState {
  const ConfirmationInitial();
}

/// Loading state
class ConfirmationLoading extends ConfirmationState {
  const ConfirmationLoading();
}

/// Loaded state with confirmation data
class ConfirmationLoaded extends ConfirmationState {
  final ConfirmationData confirmationData;

  const ConfirmationLoaded({required this.confirmationData});

  @override
  List<Object?> get props => [confirmationData];
}

/// Processing confirmation state
class ConfirmationProcessing extends ConfirmationState {
  const ConfirmationProcessing();
}

/// Confirmation success state
class ConfirmationSuccess extends ConfirmationState {
  final ConfirmationData confirmationData;

  const ConfirmationSuccess({required this.confirmationData});

  @override
  List<Object?> get props => [confirmationData];
}

/// Error state
class ConfirmationError extends ConfirmationState {
  final String message;

  const ConfirmationError(this.message);

  @override
  List<Object?> get props => [message];
}
