import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Section showing booking information
class BookingInfoSection extends StatelessWidget {
  final String bookingId;
  final String userName;
  final DateTime pickupDate;
  final DateTime returnDate;
  final String pickupLocation;
  final String returnLocation;

  const BookingInfoSection({
    super.key,
    required this.bookingId,
    required this.userName,
    required this.pickupDate,
    required this.returnDate,
    required this.pickupLocation,
    required this.returnLocation,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Booking informational',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF000000),
          ),
        ),
        const SizedBox(height: 16),
        // Booking ID
        _buildInfoRow(label: '• Booking ID', value: bookingId),
        const SizedBox(height: 12),
        // Name
        _buildInfoRow(label: '• Name', value: userName),
        const SizedBox(height: 12),
        // Pick up Date
        _buildInfoRow(
          label: '• Pick up Date',
          value:
              '${dateFormat.format(pickupDate)}  ${timeFormat.format(pickupDate).toLowerCase()}',
        ),
        const SizedBox(height: 12),
        // Return Date
        _buildInfoRow(
          label: '• Return Date',
          value:
              '${dateFormat.format(returnDate)}  ${timeFormat.format(returnDate).toLowerCase()}',
        ),
        const SizedBox(height: 12),
        // Pickup Location
        _buildInfoRow(
          label: '• Pickup Loc',
          value: pickupLocation,
          isLocation: true,
        ),
        const SizedBox(height: 12),
        // Return Location
        _buildInfoRow(
          label: '• Return Loc',
          value: returnLocation,
          isLocation: true,
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    bool isLocation = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF7F7F7F),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isLocation)
                const Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Color(0xFF7F7F7F),
                  ),
                ),
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
