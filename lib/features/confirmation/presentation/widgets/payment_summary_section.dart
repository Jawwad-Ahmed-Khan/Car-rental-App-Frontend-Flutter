import 'package:flutter/material.dart';

/// Section showing payment summary
class PaymentSummarySection extends StatelessWidget {
  final String transactionId;
  final double amount;
  final double serviceFee;
  final double totalAmount;
  final String paymentMethod;
  final String paymentMethodIcon;
  final double pricePerDay;
  final int rentDays;

  const PaymentSummarySection({
    super.key,
    required this.transactionId,
    required this.amount,
    required this.serviceFee,
    required this.totalAmount,
    required this.paymentMethod,
    required this.paymentMethodIcon,
    this.pricePerDay = 0.0,
    this.rentDays = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF000000),
          ),
        ),
        const SizedBox(height: 16),
        // Transaction ID
        _buildRow(label: 'Trx ID', value: transactionId, isBold: true),
        const SizedBox(height: 12),
        // Base Fare
        _buildRow(
          label: 'Base Fare',
          value: '\$${pricePerDay.toStringAsFixed(0)}',
        ),
        const SizedBox(height: 12),
        // Rent Days
        _buildRow(label: 'Rent Days', value: '$rentDays Days'),
        const SizedBox(height: 12),
        // Amount (Total Rental Price)
        _buildRow(label: 'Amount', value: '\$${amount.toStringAsFixed(0)}'),
        const SizedBox(height: 12),
        // Service fee
        _buildRow(
          label: 'Service fee',
          value: '\$${serviceFee.toStringAsFixed(0)}',
        ),
        const SizedBox(height: 16),
        // Divider
        Container(height: 1, color: const Color(0xFFD7D7D7)),
        const SizedBox(height: 16),
        // Total amount
        _buildRow(
          label: 'Total amount',
          value: '\$${totalAmount.toStringAsFixed(0)}',
          isBold: true,
          isTotal: true,
        ),
        const SizedBox(height: 16),
        // Payment method
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Payment with',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF7F7F7F),
              ),
            ),
            _buildPaymentIcon(),
          ],
        ),
      ],
    );
  }

  Widget _buildRow({
    required String label,
    required String value,
    bool isBold = false,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            fontSize: 14,
            color: isTotal ? const Color(0xFF000000) : const Color(0xFF7F7F7F),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            fontSize: 14,
            color: const Color(0xFF000000),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentIcon() {
    // Show Mastercard icon
    return Container(
      width: 40,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFD7D7D7)),
      ),
      child: Center(
        child: Image.asset(
          'assets/icons/mastercard.png',
          width: 32,
          height: 20,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEB001B),
                    shape: BoxShape.circle,
                  ),
                ),
                Transform.translate(
                  offset: const Offset(-4, 0),
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF79E1B),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
