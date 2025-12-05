import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/confirmation_bloc.dart';
import '../bloc/confirmation_event.dart';
import '../bloc/confirmation_state.dart';
import '../widgets/confirmation_app_bar.dart';
import '../widgets/confirmation_progress_stepper.dart';
import '../widgets/car_summary_card.dart';
import '../widgets/booking_info_section.dart';
import '../widgets/payment_summary_section.dart';
import '../widgets/confirm_button.dart';
import '../../../../routes/app_router.dart';

/// Main Confirmation page
class ConfirmationPage extends StatelessWidget {
  // Booking details
  final String userName;
  final DateTime pickupDate;
  final DateTime returnDate;
  final String pickupLocation;
  final String returnLocation;

  // Car details
  final String carId;
  final String carName;
  final String carDescription;
  final String carImageUrl;
  final double carRating;
  final int reviewCount;

  // Payment details
  final double amount;
  final double serviceFee;
  final String paymentMethod;
  final String paymentMethodIcon;
  final double pricePerDay;

  const ConfirmationPage({
    super.key,
    required this.userName,
    required this.pickupDate,
    required this.returnDate,
    required this.pickupLocation,
    required this.returnLocation,
    required this.carId,
    required this.carName,
    required this.carDescription,
    required this.carImageUrl,
    required this.carRating,
    required this.reviewCount,
    required this.amount,
    required this.serviceFee,
    required this.paymentMethod,
    required this.paymentMethodIcon,
    this.pricePerDay = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmationBloc()
        ..add(
          LoadConfirmationData(
            userName: userName,
            pickupDate: pickupDate,
            returnDate: returnDate,
            pickupLocation: pickupLocation,
            returnLocation: returnLocation,
            carId: carId,
            carName: carName,
            carDescription: carDescription,
            carImageUrl: carImageUrl,
            carRating: carRating,
            reviewCount: reviewCount,
            amount: amount,
            serviceFee: serviceFee,
            paymentMethod: paymentMethod,
            paymentMethodIcon: paymentMethodIcon,
            pricePerDay: pricePerDay,
          ),
        ),
      child: const _ConfirmationContent(),
    );
  }
}

class _ConfirmationContent extends StatelessWidget {
  const _ConfirmationContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfirmationBloc, ConfirmationState>(
      listener: (context, state) {
        if (state is ConfirmationSuccess) {
          // Navigate to Payment States page with all the data
          Navigator.pushNamed(
            context,
            AppRouter.paymentStates,
            arguments: {
              'carName': state.confirmationData.carName,
              'pickupDate': state.confirmationData.pickupDate,
              'returnDate': state.confirmationData.returnDate,
              'userName': state.confirmationData.userName,
              'transactionId': state.confirmationData.transactionId,
              'paymentMethod': state.confirmationData.paymentMethod,
              'amount': state.confirmationData.amount,
              'serviceFee': state.confirmationData.serviceFee,
              'totalAmount': state.confirmationData.totalAmount,
            },
          );
        } else if (state is ConfirmationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is ConfirmationLoading || state is ConfirmationInitial) {
          return const Scaffold(
            backgroundColor: Color(0xFFF8F8F8),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ConfirmationProcessing) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8F8F8),
            appBar: const ConfirmationAppBar(),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFF21292B)),
                  SizedBox(height: 16),
                  Text(
                    'Processing confirmation...',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xFF7F7F7F),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is! ConfirmationLoaded) {
          return const Scaffold(
            backgroundColor: Color(0xFFF8F8F8),
            body: Center(child: Text('Something went wrong')),
          );
        }

        final data = state.confirmationData;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F8F8),
          appBar: const ConfirmationAppBar(),
          body: Column(
            children: [
              // Divider
              Container(height: 1, color: const Color(0xFFD7D7D7)),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Progress stepper
                      const ConfirmationProgressStepper(),

                      // Car Summary Card
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CarSummaryCard(
                          carName: data.carName,
                          carDescription: data.carDescription,
                          carImageUrl: data.carImageUrl,
                          rating: data.carRating,
                          reviewCount: data.reviewCount,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Booking Info Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: BookingInfoSection(
                          bookingId: data.bookingId,
                          userName: data.userName,
                          pickupDate: data.pickupDate,
                          returnDate: data.returnDate,
                          pickupLocation: data.pickupLocation,
                          returnLocation: data.returnLocation,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Divider
                      Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        color: const Color(0xFFD7D7D7),
                      ),
                      const SizedBox(height: 24),

                      // Payment Summary Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: PaymentSummarySection(
                          transactionId: data.transactionId,
                          amount: data.amount,
                          serviceFee: data.serviceFee,
                          totalAmount: data.totalAmount,
                          paymentMethod: data.paymentMethod,
                          paymentMethodIcon: data.paymentMethodIcon,
                          pricePerDay: data.pricePerDay,
                          rentDays:
                              data.returnDate
                                      .difference(data.pickupDate)
                                      .inDays ==
                                  0
                              ? 1
                              : data.returnDate
                                    .difference(data.pickupDate)
                                    .inDays,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Confirm Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ConfirmButton(
                          onPressed: () {
                            context.read<ConfirmationBloc>().add(
                              const ConfirmBooking(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
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
