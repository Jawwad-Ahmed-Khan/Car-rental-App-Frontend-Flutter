import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_initial_booking_details.dart';
import '../../../booking/domain/usecases/create_booking.dart';
import '../../../booking/domain/entities/booking.dart';
import '../../domain/entities/booking_details.dart';
import 'booking_details_event.dart';
import 'booking_details_state.dart';

/// BLoC for managing booking details form state
class BookingDetailsBloc
    extends Bloc<BookingDetailsEvent, BookingDetailsState> {
  final GetInitialBookingDetails _getInitialBookingDetails;
  final CreateBooking _createBooking;

  BookingDetailsBloc({
    required GetInitialBookingDetails getInitialBookingDetails,
    required CreateBooking createBooking,
  }) : _getInitialBookingDetails = getInitialBookingDetails,
       _createBooking = createBooking,
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
    on<UpdateCnic>(_onUpdateCnic);
    on<UpdatePickupLocation>(_onUpdatePickupLocation);
    on<UpdateReturnLocation>(_onUpdateReturnLocation);
    on<SubmitBookingEvent>(_onSubmitBooking);
  }

  Future<void> _onInitialize(
    InitializeBookingDetails event,
    Emitter<BookingDetailsState> emit,
  ) async {
    try {
      final booking = await _getInitialBookingDetails(
        event.carId,
        event.price,
        event.carName,
        event.carImageUrl,
      );
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
      emit(
        currentState.copyWith(
          bookingDetails: currentState.bookingDetails.copyWith(
            fullName: event.fullName,
          ),
        ),
      );
    }
  }

  void _onUpdateEmail(UpdateEmail event, Emitter<BookingDetailsState> emit) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      emit(
        currentState.copyWith(
          bookingDetails: currentState.bookingDetails.copyWith(
            email: event.email,
          ),
        ),
      );
    }
  }

  void _onUpdateContact(
    UpdateContact event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      emit(
        currentState.copyWith(
          bookingDetails: currentState.bookingDetails.copyWith(
            contact: event.contact,
          ),
        ),
      );
    }
  }

  void _onSelectGender(SelectGender event, Emitter<BookingDetailsState> emit) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      emit(
        currentState.copyWith(
          bookingDetails: currentState.bookingDetails.copyWith(
            gender: event.gender,
          ),
        ),
      );
    }
  }

  void _onSelectRentalType(
    SelectRentalType event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      emit(
        currentState.copyWith(
          bookingDetails: currentState.bookingDetails.copyWith(
            rentalType: event.rentalType,
          ),
        ),
      );
    }
  }

  void _onSelectPickupDate(
    SelectPickupDate event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      final updatedBooking = currentState.bookingDetails.copyWith(
        pickupDate: event.date,
      );

      // Recalculate price
      final newPrice = updatedBooking.pricePerDay * updatedBooking.rentalDays;

      emit(
        currentState.copyWith(
          bookingDetails: updatedBooking.copyWith(totalPrice: newPrice),
        ),
      );
    }
  }

  void _onSelectReturnDate(
    SelectReturnDate event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      final updatedBooking = currentState.bookingDetails.copyWith(
        returnDate: event.date,
      );

      // Recalculate price
      final newPrice = updatedBooking.pricePerDay * updatedBooking.rentalDays;

      emit(
        currentState.copyWith(
          bookingDetails: updatedBooking.copyWith(totalPrice: newPrice),
        ),
      );
    }
  }

  void _onToggleBookWithDriver(
    ToggleBookWithDriver event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      emit(
        currentState.copyWith(
          bookingDetails: currentState.bookingDetails.copyWith(
            bookWithDriver: !currentState.bookingDetails.bookWithDriver,
          ),
        ),
      );
    }
  }

  void _onUpdateCnic(UpdateCnic event, Emitter<BookingDetailsState> emit) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      emit(
        currentState.copyWith(
          bookingDetails: currentState.bookingDetails.copyWith(
            cnic: event.cnic,
          ),
        ),
      );
    }
  }

  void _onUpdatePickupLocation(
    UpdatePickupLocation event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      emit(
        currentState.copyWith(
          bookingDetails: currentState.bookingDetails.copyWith(
            pickupLocation: event.location,
          ),
        ),
      );
    }
  }

  void _onUpdateReturnLocation(
    UpdateReturnLocation event,
    Emitter<BookingDetailsState> emit,
  ) {
    if (state is BookingDetailsLoaded) {
      final currentState = state as BookingDetailsLoaded;
      emit(
        currentState.copyWith(
          bookingDetails: currentState.bookingDetails.copyWith(
            returnLocation: event.location,
          ),
        ),
      );
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
        final booking = Booking(
          vehicleId: int.tryParse(currentState.bookingDetails.carId) ?? 0,
          name: currentState.bookingDetails.fullName,
          email: currentState.bookingDetails.email,
          phone: currentState.bookingDetails.contact,
          cnic: currentState.bookingDetails.cnic,
          pickupDate:
              currentState.bookingDetails.pickupDate?.toIso8601String() ?? '',
          returnDate:
              currentState.bookingDetails.returnDate?.toIso8601String() ?? '',
          pickupLocation: currentState.bookingDetails.pickupLocation,
          returnLocation: currentState.bookingDetails.returnLocation,
          serviceType: currentState.bookingDetails.bookWithDriver
              ? 'with_driver'
              : 'self_drive',
          priceModel: currentState.bookingDetails.rentalType == RentalType.day
              ? 'per_day'
              : 'per_hr',
        );

        final result = await _createBooking(booking);

        result.fold(
          (failure) {
            emit(BookingDetailsError(failure.message));
            emit(currentState);
          },
          (createdBooking) {
            emit(
              BookingDetailsSuccess(
                booking: createdBooking,
                bookingDetails: currentState.bookingDetails,
              ),
            );
          },
        );
      } catch (e) {
        emit(BookingDetailsError(e.toString()));
        emit(currentState);
      }
    }
  }
}
