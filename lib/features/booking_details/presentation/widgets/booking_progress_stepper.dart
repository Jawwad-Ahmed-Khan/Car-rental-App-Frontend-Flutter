import 'package:flutter/material.dart';

/// Progress stepper showing 3 steps: Booking details, Payment methods, Confirmation
class BookingProgressStepper extends StatelessWidget {
  final int currentStep;

  const BookingProgressStepper({
    super.key,
    this.currentStep = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFD7D7D7), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Step 1: Booking details
          Expanded(
            child: _buildStep(
              index: 0,
              label: 'Booking details',
              isActive: currentStep >= 0,
              isCompleted: currentStep > 0,
            ),
          ),
          // Line connector
          _buildConnector(isActive: currentStep > 0),
          // Step 2: Payment methods
          Expanded(
            child: _buildStep(
              index: 1,
              label: 'Payment methods',
              isActive: currentStep >= 1,
              isCompleted: currentStep > 1,
            ),
          ),
          // Line connector
          _buildConnector(isActive: currentStep > 1),
          // Step 3: Confirmation
          Expanded(
            child: _buildStep(
              index: 2,
              label: 'confirmation',
              isActive: currentStep >= 2,
              isCompleted: currentStep > 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required int index,
    required String label,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? const Color(0xFF21292B) : Colors.white,
            border: Border.all(
              color: isActive ? const Color(0xFF21292B) : const Color(0xFFD7D7D7),
              width: 2,
            ),
          ),
          child: isCompleted
              ? const Icon(Icons.check, size: 10, color: Colors.white)
              : null,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.black : const Color(0xFF7F7F7F),
          ),
        ),
      ],
    );
  }

  Widget _buildConnector({required bool isActive}) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 24),
        color: isActive ? const Color(0xFF21292B) : const Color(0xFFD7D7D7),
      ),
    );
  }
}
