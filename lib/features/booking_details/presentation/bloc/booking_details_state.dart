import 'package:equatable/equatable.dart';
import '../../domain/entities/booking_details.dart';
import '../../../booking/domain/entities/booking.dart';

/// Base state for booking details
abstract class BookingDetailsState extends Equatable {
  const BookingDetailsState();

  @override
  List<Object?> get props => [];
}

/// Initial/Loading state
class BookingDetailsInitial extends BookingDetailsState {
  const BookingDetailsInitial();
}

/// Loaded state with booking form data
class BookingDetailsLoaded extends BookingDetailsState {
  final BookingDetails bookingDetails;
  final int currentStep;

  const BookingDetailsLoaded({
    required this.bookingDetails,
    this.currentStep = 0,
  });

  BookingDetailsLoaded copyWith({
    BookingDetails? bookingDetails,
    int? currentStep,
  }) {
    return BookingDetailsLoaded(
      bookingDetails: bookingDetails ?? this.bookingDetails,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  @override
  List<Object?> get props => [bookingDetails, currentStep];
}

/// Submitting state
class BookingDetailsSubmitting extends BookingDetailsState {
  const BookingDetailsSubmitting();
}

/// Success state after submission
class BookingDetailsSuccess extends BookingDetailsState {
  final Booking booking;
  final BookingDetails bookingDetails;

  const BookingDetailsSuccess({
    required this.booking,
    required this.bookingDetails,
  });

  @override
  List<Object?> get props => [booking, bookingDetails];
}

/// Error state
class BookingDetailsError extends BookingDetailsState {
  final String message;

  const BookingDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
