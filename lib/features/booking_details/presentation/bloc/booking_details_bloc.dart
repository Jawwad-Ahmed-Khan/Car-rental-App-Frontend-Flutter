import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/booking_details_local_data_source.dart';
import '../../data/repositories/booking_details_repository_impl.dart';
import '../../domain/usecases/get_initial_booking_details.dart';
import '../../domain/usecases/submit_booking.dart';
import 'booking_details_event.dart';
import 'booking_details_state.dart';

/// BLoC for managing booking details form state
class BookingDetailsBloc
    extends Bloc<BookingDetailsEvent, BookingDetailsState> {
  final GetInitialBookingDetails _getInitialBookingDetails;
  final SubmitBooking _submitBooking;

  BookingDetailsBloc()
      : _getInitialBookingDetails = GetInitialBookingDetails(
          BookingDetailsRepositoryImpl(
            localDataSource: BookingDetailsLocalDataSource(),
          ),
        ),
        _submitBooking = SubmitBooking(
          BookingDetailsRepositoryImpl(
            localDataSource: BookingDetailsLocalDataSource(),
          ),
        ),
        super(const BookingDetailsInitial()) {
    on<InitializeBookingDetails>(_onInitialize);
    on<UpdateFullName>(_onUpdateFullName);
    on<UpdateEmail>(_onUpdateEmail);
    on<UpdateContact>(_onUpdateContact);
    on<SelectGender>(_onSelectGender);
    on<SelectRentalType>(_onSelectRentalType);
    on<SelectPickupDate>(_onSelectPickupDate);
    on<SelectReturnDate>(_onSelectReturnDate);
    on<ToggleBookWithDriver>(_onToggleBookWithDriver);
    on<SubmitBookingEvent>(_onSubmitBooking);
  }

  Future<void> _onInitialize(
    InitializeBookingDetails event,
    Emitter<BookingDetailsState> emit,
  ) async {
    try {
      final booking =
          await _getInitialBookingDetails(event.carId, event.price);
      emit(BookingDetailsLoaded(bookingDetails: booking));
    } catch (e) {
      emit(BookingDetailsError(e.toString()));
    }
  }

  void _onUpdateFullName(
    UpdateFullName event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      emit(currentState.copyWith(
        bookingDetails:
            currentState.bookingDetails.copyWith(fullName: event.fullName),
      ));
    }
  }

  void _onUpdateEmail(
    UpdateEmail event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      emit(currentState.copyWith(
        bookingDetails:
            currentState.bookingDetails.copyWith(email: event.email),
      ));
    }
  }

  void _onUpdateContact(
    UpdateContact event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      emit(currentState.copyWith(
        bookingDetails:
            currentState.bookingDetails.copyWith(contact: event.contact),
      ));
    }
  }

  void _onSelectGender(
    SelectGender event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      emit(currentState.copyWith(
        bookingDetails:
            currentState.bookingDetails.copyWith(gender: event.gender),
      ));
    }
  }

  void _onSelectRentalType(
    SelectRentalType event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      emit(currentState.copyWith(
        bookingDetails:
            currentState.bookingDetails.copyWith(rentalType: event.rentalType),
      ));
    }
  }

  void _onSelectPickupDate(
    SelectPickupDate event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      final updatedBooking = currentState.bookingDetails.copyWith(pickupDate: event.date);
      
      // Recalculate price
      final newPrice = updatedBooking.pricePerDay * updatedBooking.rentalDays;
      
      emit(currentState.copyWith(
        bookingDetails: updatedBooking.copyWith(totalPrice: newPrice),
      ));
    }
  }

  void _onSelectReturnDate(
    SelectReturnDate event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      final updatedBooking = currentState.bookingDetails.copyWith(returnDate: event.date);
      
      // Recalculate price
      final newPrice = updatedBooking.pricePerDay * updatedBooking.rentalDays;
      
      emit(currentState.copyWith(
        bookingDetails: updatedBooking.copyWith(totalPrice: newPrice),
      ));
    }
  }

  void _onToggleBookWithDriver(
    ToggleBookWithDriver event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      emit(currentState.copyWith(
        bookingDetails: currentState.bookingDetails.copyWith(
          bookWithDriver: !currentState.bookingDetails.bookWithDriver,
        ),
      ));
    }
  }

  Future<void> _onSubmitBooking(
    SubmitBookingEvent event,
    Emitter<BookingDetailsState> emit,
  ) async {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;

      if (!currentState.bookingDetails.isValid) {
        emit(const BookingDetailsError('Please fill all required fields'));
        emit(currentState);
        return;
      }

      emit(const BookingDetailsSubmitting());

      try {
        final success = await _submitBooking(currentState.bookingDetails);
        if (success) {
          emit(const BookingDetailsSuccess());
        } else {
          emit(const BookingDetailsError('Failed to submit booking'));
          emit(currentState);
        }
      } catch (e) {
        emit(BookingDetailsError(e.toString()));
        emit(currentState);
      }
    }
  }
}
