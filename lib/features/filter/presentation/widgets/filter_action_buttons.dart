import 'package:flutter/material.dart';

/// Widget for filter action buttons (Clear All / Show X Cars)
class FilterActionButtons extends StatelessWidget {
  final int carsCount;
  final VoidCallback onClearAll;
  final VoidCallback onShowCars;

  const FilterActionButtons({
    super.key,
    required this.carsCount,
    required this.onClearAll,
    required this.onShowCars,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFD7D7D7)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Clear All button
            Expanded(
              child: GestureDetector(
                onTap: onClearAll,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: const Text(
                    'Clear All',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Show X Cars button
            Expanded(
              child: GestureDetector(
                onTap: onShowCars,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF21292B),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Show $carsCount+ Cars',
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
