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
import '../widgets/car_location_display.dart';
import '../widgets/pay_now_button.dart';
import '../../../booking/presentation/pages/date_time_picker_dialog.dart';
import '../../../../routes/app_router.dart';

/// Main Booking Details page
class BookingDetailsPage extends StatelessWidget {
  final String carId;
  final double price;

  const BookingDetailsPage({
    super.key,
    required this.carId,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingDetailsBloc()
        ..add(InitializeBookingDetails(carId: carId, price: price)),
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
          Navigator.of(context).pop();
        } else if (state is BookingDetailsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
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
                          context
                              .read<BookingDetailsBloc>()
                              .add(const ToggleBookWithDriver());
                        },
                      ),
                      const SizedBox(height: 20),

                      // Full Name Field
                      BookingTextField(
                        hint: 'Full Name',
                        icon: Icons.person_outline,
                        value: booking.fullName,
                        onChanged: (value) {
                          context
                              .read<BookingDetailsBloc>()
                              .add(UpdateFullName(value));
                        },
                      ),
                      const SizedBox(height: 16),

                      // Email Field
                      BookingTextField(
                        hint: 'Email Address',
                        icon: Icons.email_outlined,
                        value: booking.email,
                        onChanged: (value) {
                          context
                              .read<BookingDetailsBloc>()
                              .add(UpdateEmail(value));
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      // Contact Field
                      BookingTextField(
                        hint: 'Contact',
                        icon: Icons.phone_outlined,
                        value: booking.contact,
                        onChanged: (value) {
                          context
                              .read<BookingDetailsBloc>()
                              .add(UpdateContact(value));
                        },
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 24),

                      // Gender Selector
                      GenderSelector(
                        selectedGender: booking.gender,
                        onGenderSelected: (gender) {
                          context
                              .read<BookingDetailsBloc>()
                              .add(SelectGender(gender));
                        },
                      ),
                      const SizedBox(height: 24),

                      // Rental Type Selector
                      RentalTypeSelector(
                        selectedType: booking.rentalType,
                        onTypeSelected: (type) {
                          context
                              .read<BookingDetailsBloc>()
                              .add(SelectRentalType(type));
                        },
                      ),
                      const SizedBox(height: 20),

                      // Rental Date Section
                      RentalDateSection(
                        pickupDate: booking.pickupDate,
                        returnDate: booking.returnDate,
                        onPickupDateTap: () async {
                          final result =
                              await DateTimePickerDialog.show(context);
                          if (result != null && context.mounted) {
                            context.read<BookingDetailsBloc>().add(
                                  SelectPickupDate(
                                      result.startDate ?? result.startTime),
                                );
                          }
                        },
                        onReturnDateTap: () async {
                          final result =
                              await DateTimePickerDialog.show(context);
                          if (result != null && context.mounted) {
                            context.read<BookingDetailsBloc>().add(
                                  SelectReturnDate(
                                      result.endDate ?? result.endTime),
                                );
                          }
                        },
                      ),
                      const SizedBox(height: 24),

                      // Car Location Display
                      CarLocationDisplay(location: booking.location),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Pay Now Button
              PayNowButton(
                totalPrice: booking.totalPrice,
                onPressed: () {
                  if (!booking.isValid) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all required fields (Name, Email, Contact)'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  
                  // Navigate to Payment Methods page with all booking details
                  Navigator.pushNamed(
                    context,
                    AppRouter.paymentMethods,
                    arguments: {
                      'totalAmount': booking.totalPrice,
                      'userName': booking.fullName.isNotEmpty 
                          ? booking.fullName 
                          : 'Benjamin Jack',
                      'pickupDate': booking.pickupDate ?? DateTime.now(),
                      'returnDate': booking.returnDate ?? DateTime.now().add(const Duration(days: 3)),
                      'location': booking.location.isNotEmpty 
                          ? booking.location 
                          : 'Shore Dr, Chicago 0062 Usa',
                      'carId': booking.carId,
                      // Car details - using defaults matching Figma design
                      'carName': 'Tesla Model S',
                      'carDescription': 'A car with high specs that are rented at an affordable price.',
                      'carImageUrl': 'assets/images/Tesla_car_2.png',
                      'carRating': 5.0,
                      'reviewCount': 100,
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
