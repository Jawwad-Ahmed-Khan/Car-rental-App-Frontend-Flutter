import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/booking_details_bloc.dart';
import '../bloc/booking_details_event.dart';
import '../bloc/booking_details_state.dart';
import '../widgets/booking_app_bar.dart';
import '../widgets/booking_progress_stepper.dart';
import '../widgets/book_with_driver_toggle.dart';
import '../widgets/booking_text_field.dart';
import '../widgets/gender_selector.dart';
import '../widgets/rental_type_selector.dart';
import '../widgets/rental_date_section.dart';
import '../../../booking/presentation/pages/date_time_picker_dialog.dart';
import '../../../booking/domain/usecases/create_booking.dart';
import '../../domain/usecases/get_initial_booking_details.dart';
import '../../../../di/injection_container.dart';
import '../../../../routes/app_router.dart';

/// Main Booking Details page
class BookingDetailsPage extends StatelessWidget {
  final String carId;
  final double price;
  final String carName;
  final String carImageUrl;

  const BookingDetailsPage({
    super.key,
    required this.carId,
    required this.price,
    required this.carName,
    required this.carImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookingDetailsBloc(
            getInitialBookingDetails: sl<GetInitialBookingDetails>(),
            createBooking: sl<CreateBooking>(),
          )..add(
            InitializeBookingDetails(
              carId: carId,
              price: price,
              carName: carName,
              carImageUrl: carImageUrl,
            ),
          ),
      child: const _BookingDetailsContent(),
    );
  }
}

class _BookingDetailsContent extends StatelessWidget {
  const _BookingDetailsContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingDetailsBloc, BookingDetailsState>(
      listener: (context, state) {
        if (state is BookingDetailsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Booking submitted successfully!'),
              backgroundColor: Color(0xFF21292B),
            ),
          );

          // Navigate to Payment Methods page with booking object
          Navigator.pushNamed(
            context,
            AppRouter.paymentMethods,
            arguments: {
              'booking': state.booking,
              'totalAmount': state.bookingDetails.totalPrice,
              'carName': state.bookingDetails.carName,
              'carImageUrl': state.bookingDetails.carImageUrl,
              'pickupDate': state.bookingDetails.pickupDate,
              'returnDate': state.bookingDetails.returnDate,
              'pricePerDay': state.bookingDetails.pricePerDay,
            },
          );
        } else if (state is BookingDetailsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is BookingDetailsInitial) {
          return const Scaffold(
            backgroundColor: Color(0xFFF8F8F8),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is BookingDetailsSubmitting) {
          return const Scaffold(
            backgroundColor: Color(0xFFF8F8F8),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is! BookingDetailsLoaded) {
          return const Scaffold(
            backgroundColor: Color(0xFFF8F8F8),
            body: Center(child: Text('Something went wrong')),
          );
        }

        final booking = state.bookingDetails;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F8F8),
          appBar: const BookingAppBar(),
          body: Column(
            children: [
              // Progress Stepper
              BookingProgressStepper(currentStep: state.currentStep),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Book with Driver Toggle
                      BookWithDriverToggle(
                        isEnabled: booking.bookWithDriver,
                        onToggle: () {
                          context.read<BookingDetailsBloc>().add(
                            const ToggleBookWithDriver(),
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      // Full Name Field
                      BookingTextField(
                        hint: 'Full Name',
                        icon: Icons.person_outline,
                        value: booking.fullName,
                        onChanged: (value) {
                          context.read<BookingDetailsBloc>().add(
                            UpdateFullName(value),
                          );
                        },
                      ),
                      const SizedBox(height: 16),

                      // Email Field
                      BookingTextField(
                        hint: 'Email Address',
                        icon: Icons.email_outlined,
                        value: booking.email,
                        onChanged: (value) {
                          context.read<BookingDetailsBloc>().add(
                            UpdateEmail(value),
                          );
                        },
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,
                      ),
                      const SizedBox(height: 16),

                      // Contact Field
                      BookingTextField(
                        hint: 'Contact',
                        icon: Icons.phone_outlined,
                        value: booking.contact,
                        onChanged: (value) {
                          context.read<BookingDetailsBloc>().add(
                            UpdateContact(value),
                          );
                        },
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),

                      // CNIC Field
                      BookingTextField(
                        hint: 'CNIC (e.g. 12345-1234567-1)',
                        icon: Icons.badge_outlined,
                        value: booking.cnic,
                        onChanged: (value) {
                          context.read<BookingDetailsBloc>().add(
                            UpdateCnic(value),
                          );
                        },
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 24),

                      // Gender Selector
                      GenderSelector(
                        selectedGender: booking.gender,
                        onGenderSelected: (gender) {
                          context.read<BookingDetailsBloc>().add(
                            SelectGender(gender),
                          );
                        },
                      ),
                      const SizedBox(height: 24),

                      // Rental Type Selector
                      RentalTypeSelector(
                        selectedType: booking.rentalType,
                        onTypeSelected: (type) {
                          context.read<BookingDetailsBloc>().add(
                            SelectRentalType(type),
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      // Rental Date Section
                      RentalDateSection(
                        pickupDate: booking.pickupDate,
                        returnDate: booking.returnDate,
                        onPickupDateTap: () async {
                          final result = await DateTimePickerDialog.show(
                            context,
                            initialStartDate: booking.pickupDate,
                            initialEndDate: booking.returnDate,
                          );
                          if (result != null && context.mounted) {
                            context.read<BookingDetailsBloc>().add(
                              SelectPickupDate(
                                result.startDate ?? result.startTime,
                              ),
                            );
                          }
                        },
                        onReturnDateTap: () async {
                          final result = await DateTimePickerDialog.show(
                            context,
                            initialStartDate: booking.pickupDate,
                            initialEndDate: booking.returnDate,
                            isSelectingEndDate: true,
                          );
                          if (result != null && context.mounted) {
                            context.read<BookingDetailsBloc>().add(
                              SelectReturnDate(
                                result.endDate ?? result.endTime,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 24),

                      // Pickup Location Field
                      BookingTextField(
                        hint: 'Pickup Location',
                        icon: Icons.location_on_outlined,
                        value: booking.pickupLocation,
                        onChanged: (value) {
                          context.read<BookingDetailsBloc>().add(
                            UpdatePickupLocation(value),
                          );
                        },
                      ),
                      const SizedBox(height: 16),

                      // Return Location Field
                      BookingTextField(
                        hint: 'Return Location',
                        icon: Icons.location_on_outlined,
                        value: booking.returnLocation,
                        onChanged: (value) {
                          context.read<BookingDetailsBloc>().add(
                            UpdateReturnLocation(value),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Continue Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!booking.isValid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all required fields'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      context.read<BookingDetailsBloc>().add(
                        const SubmitBookingEvent(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF21292B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
