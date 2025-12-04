import 'package:flutter/material.dart';

/// Header widget for the filter page with close button and title
class FilterHeader extends StatelessWidget {
  final VoidCallback onClose;

  const FilterHeader({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: onClose,
            child: Container(
              padding: const EdgeInsets.all(4),
              child: const Icon(
                Icons.close,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Filters',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // Spacer to balance the close button
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}
