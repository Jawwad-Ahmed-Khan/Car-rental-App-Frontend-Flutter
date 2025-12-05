import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/payment_states_bloc.dart';
import '../bloc/payment_states_event.dart';
import '../bloc/payment_states_state.dart';
import '../widgets/payment_states_app_bar.dart';
import '../widgets/success_badge.dart';
import '../widgets/booking_info_card.dart';
import '../widgets/transaction_detail_section.dart';
import '../widgets/receipt_buttons.dart';
import '../widgets/back_to_home_button.dart';

/// Main Payment States page
class PaymentStatesPage extends StatelessWidget {
  final String carName;
  final DateTime pickupDate;
  final DateTime returnDate;
  final String userName;
  final String transactionId;
  final String paymentMethod;
  final double amount;
  final double serviceFee;
  final double totalAmount;
  final double pricePerDay;

  const PaymentStatesPage({
    super.key,
    required this.carName,
    required this.pickupDate,
    required this.returnDate,
    required this.userName,
    required this.transactionId,
    required this.paymentMethod,
    required this.amount,
    required this.serviceFee,
    required this.totalAmount,
    this.pricePerDay = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentStatesBloc()
        ..add(
          LoadPaymentResult(
            carModel: carName,
            pickupDate: pickupDate,
            returnDate: returnDate,
            userName: userName,
            transactionId: transactionId,
            paymentMethod: paymentMethod,
            amount: amount,
            serviceFee: serviceFee,
            totalAmount: totalAmount,
            pricePerDay: pricePerDay,
          ),
        ),
      child: const _PaymentStatesContent(),
    );
  }
}

class _PaymentStatesContent extends StatelessWidget {
  const _PaymentStatesContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentStatesBloc, PaymentStatesState>(
      builder: (context, state) {
        if (state is PaymentStatesInitial) {
          return const Scaffold(
            backgroundColor: Color(0xFFF8F8F8),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final isDownloading = state is PaymentStatesDownloading;
        final isSharing = state is PaymentStatesSharing;

        // Get payment result from loaded state or continue with current state
        final paymentResult = state is PaymentStatesLoaded
            ? state.paymentResult
            : null;

        if (paymentResult == null) {
          return const Scaffold(
            backgroundColor: Color(0xFFF8F8F8),
            body: Center(child: Text('Something went wrong')),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF8F8F8),
          appBar: const PaymentStatesAppBar(),
          body: Column(
            children: [
              // Divider
              Container(height: 1, color: const Color(0xFFD7D7D7)),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 32),

                      // Success Badge
                      const SuccessBadge(),
                      const SizedBox(height: 32),

                      // Booking Info Card
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: BookingInfoCard(
                          carModel: paymentResult.carModel,
                          pickupDate: paymentResult.pickupDate,
                          returnDate: paymentResult.returnDate,
                          userName: paymentResult.userName,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Transaction Detail Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TransactionDetailSection(
                          transactionId: paymentResult.transactionId,
                          transactionDate: paymentResult.transactionDate,
                          paymentMethod: paymentResult.paymentMethod,
                          maskedCardNumber: paymentResult.maskedCardNumber,
                          amount: paymentResult.amount,
                          serviceFee: paymentResult.serviceFee,
                          tax: paymentResult.tax,
                          totalAmount: paymentResult.totalAmount,
                          pricePerDay: paymentResult.pricePerDay,
                          rentDays:
                              paymentResult.returnDate
                                      .difference(paymentResult.pickupDate)
                                      .inDays ==
                                  0
                              ? 1
                              : paymentResult.returnDate
                                    .difference(paymentResult.pickupDate)
                                    .inDays,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Receipt Buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ReceiptButtons(
                          isDownloading: isDownloading,
                          isSharing: isSharing,
                          onDownload: () {
                            context.read<PaymentStatesBloc>().add(
                              const DownloadReceipt(),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Receipt downloaded successfully!',
                                ),
                                backgroundColor: Color(0xFF2ECC71),
                              ),
                            );
                          },
                          onShare: () {
                            context.read<PaymentStatesBloc>().add(
                              const ShareReceipt(),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Receipt ready to share!'),
                                backgroundColor: Color(0xFF2ECC71),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Back to Home Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: BackToHomeButton(
                          onPressed: () {
                            // Navigate back to home and clear the stack
                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
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
