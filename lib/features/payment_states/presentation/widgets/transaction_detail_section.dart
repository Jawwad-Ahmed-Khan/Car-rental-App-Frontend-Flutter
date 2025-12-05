import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Section showing transaction details
class TransactionDetailSection extends StatelessWidget {
  final String transactionId;
  final DateTime transactionDate;
  final String paymentMethod;
  final String maskedCardNumber;
  final double amount;
  final double serviceFee;
  final double tax;
  final double totalAmount;
  final double pricePerDay;
  final int rentDays;

  const TransactionDetailSection({
    super.key,
    required this.transactionId,
    required this.transactionDate,
    required this.paymentMethod,
    required this.maskedCardNumber,
    required this.amount,
    required this.serviceFee,
    required this.tax,
    required this.totalAmount,
    this.pricePerDay = 0.0,
    this.rentDays = 1,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transaction  detail',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF000000),
          ),
        ),
        const SizedBox(height: 16),
        // Transaction ID
        _buildRow(label: 'Transaction ID', value: transactionId, isBold: true),
        const SizedBox(height: 12),
        // Transaction Date
        _buildRow(
          label: 'Transaction Date',
          value:
              '${dateFormat.format(transactionDate)} - ${timeFormat.format(transactionDate).toLowerCase()}',
        ),
        const SizedBox(height: 12),
        // Payment Method
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Payment  Method',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF7F7F7F),
              ),
            ),
            if (maskedCardNumber.isEmpty)
              Text(
                paymentMethod,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF000000),
                ),
              )
            else
              Row(
                children: [
                  // Mastercard icon
                  _buildPaymentIcon(),
                  const SizedBox(width: 8),
                  Text(
                    maskedCardNumber,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: 20),
        // Divider
        Container(height: 1, color: const Color(0xFFD7D7D7)),
        const SizedBox(height: 16),
        // Base Fare
        _buildRow(
          label: 'Base Fare',
          value: '\$${pricePerDay.toStringAsFixed(0)}',
        ),
        const SizedBox(height: 12),
        // Rent Days
        _buildRow(label: 'Rent Days', value: '$rentDays Days'),
        const SizedBox(height: 12),
        // Amount
        _buildRow(label: 'Amount', value: '\$${amount.toStringAsFixed(0)}'),
        const SizedBox(height: 12),
        // Service fee
        _buildRow(
          label: 'Service fee',
          value: '\$${serviceFee.toStringAsFixed(0)}',
        ),
        const SizedBox(height: 12),
        // Tax
        _buildRow(label: 'Tax', value: '\$${tax.toStringAsFixed(0)}'),
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
    return Container(
      width: 24,
      height: 16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFEB001B),
              shape: BoxShape.circle,
            ),
          ),
          Transform.translate(
            offset: const Offset(-3, 0),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFFF79E1B),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
