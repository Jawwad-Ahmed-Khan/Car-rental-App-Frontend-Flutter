import 'package:flutter/material.dart';

/// Progress stepper showing booking flow steps for Confirmation page
class ConfirmationProgressStepper extends StatelessWidget {
  const ConfirmationProgressStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      color: const Color(0xFFF8F8F8),
      child: Row(
        children: [
          // Step 1 - Booking details (completed)
          _buildStep(
            label: 'Booking details',
            isCompleted: true,
            isActive: false,
          ),
          // Line between step 1 and 2
          Expanded(
            child: Container(
              height: 2,
              color: const Color(0xFF21292B),
            ),
          ),
          // Step 2 - Payment methods (completed)
          _buildStep(
            label: 'Payment methods',
            isCompleted: true,
            isActive: false,
          ),
          // Line between step 2 and 3
          Expanded(
            child: Container(
              height: 2,
              color: const Color(0xFF21292B),
            ),
          ),
          // Step 3 - Confirmation (active)
          _buildStep(
            label: 'confirmation',
            isCompleted: false,
            isActive: true,
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
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted || isActive
                ? const Color(0xFF21292B)
                : Colors.white,
            border: Border.all(
              color: const Color(0xFFD7D7D7),
              width: isCompleted || isActive ? 0 : 1,
            ),
          ),
          child: isCompleted
              ? const Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.white,
                )
              : isActive
                  ? const Center(
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.white,
                      ),
                    )
                  : null,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            fontSize: 11,
            color: isActive || isCompleted
                ? const Color(0xFF000000)
                : const Color(0xFF7F7F7F),
          ),
        ),
      ],
    );
  }
}
