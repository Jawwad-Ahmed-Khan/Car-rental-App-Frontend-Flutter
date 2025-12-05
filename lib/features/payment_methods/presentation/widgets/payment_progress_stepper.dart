import 'package:flutter/material.dart';

/// Progress stepper widget showing booking flow steps
class PaymentProgressStepper extends StatelessWidget {
  const PaymentProgressStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      color: const Color(0xFFF8F8F8),
      child: Row(
        children: [
          // Step 1: Booking details (completed)
          _buildStep(
            label: 'Booking details',
            isCompleted: true,
            isActive: false,
          ),
          
          // Line between steps
          Expanded(
            child: Container(
              height: 2,
              color: const Color(0xFF21292B),
            ),
          ),
          
          // Step 2: Payment methods (active)
          _buildStep(
            label: 'Payment methods',
            isCompleted: false,
            isActive: true,
          ),
          
          // Line between steps
          Expanded(
            child: Container(
              height: 2,
              color: const Color(0xFFD7D7D7),
            ),
          ),
          
          // Step 3: Confirmation
          _buildStep(
            label: 'confirmation',
            isCompleted: false,
            isActive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required String label,
    required bool isCompleted,
    required bool isActive,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circle indicator
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted || isActive
                ? const Color(0xFF21292B)
                : Colors.white,
            border: Border.all(
              color: isCompleted || isActive
                  ? const Color(0xFF21292B)
                  : const Color(0xFFD7D7D7),
              width: 2,
            ),
          ),
          child: isCompleted
              ? const Icon(
                  Icons.check,
                  size: 10,
                  color: Colors.white,
                )
              : null,
        ),
        const SizedBox(height: 8),
        // Label
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            fontSize: 11,
            color: isActive
                ? const Color(0xFF000000)
                : const Color(0xFF7F7F7F),
          ),
        ),
      ],
    );
  }
}
