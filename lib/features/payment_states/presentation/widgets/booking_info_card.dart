import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Card showing booking information summary
class BookingInfoCard extends StatelessWidget {
  final String carModel;
  final DateTime pickupDate;
  final DateTime returnDate;
  final String userName;

  const BookingInfoCard({
    super.key,
    required this.carModel,
    required this.pickupDate,
    required this.returnDate,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('ddMMMyy');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD7D7D7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Booking information',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF000000),
            ),
          ),
          const SizedBox(height: 16),
          // Car Model
          _buildRow(
            label: 'Car Model',
            value: carModel,
          ),
          const SizedBox(height: 12),
          // Rental Date
          _buildRow(
            label: 'Rental Date',
            value: '${dateFormat.format(pickupDate)} - ${dateFormat.format(returnDate)}',
          ),
          const SizedBox(height: 12),
          // Name
          _buildRow(
            label: 'Name',
            value: userName,
          ),
        ],
      ),
    );
  }

  Widget _buildRow({
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF7F7F7F),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF000000),
          ),
        ),
      ],
    );
  }
}
