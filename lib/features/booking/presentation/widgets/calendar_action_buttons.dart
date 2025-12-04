import 'package:flutter/material.dart';

/// Widget for Cancel and Done action buttons
class CalendarActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onDone;

  const CalendarActionButtons({
    super.key,
    required this.onCancel,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Cancel Button (outlined)
          Expanded(
            child: GestureDetector(
              onTap: onCancel,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFFD7D7D7),
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Done Button (filled)
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: onDone,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF21292B),
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
