import 'package:flutter/material.dart';

/// Toggle widget for "Book with driver" option
class BookWithDriverToggle extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onToggle;

  const BookWithDriverToggle({
    super.key,
    required this.isEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD7D7D7)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Book with driver',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Don't have a driver? book with driver.",
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5A5A5A),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (_) => onToggle(),
            thumbColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const Color(0xFF21292B);
              }
              return Colors.white;
            }),
            trackColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const Color(0xFF21292B).withValues(alpha: 0.5);
              }
              return const Color(0xFFD7D7D7);
            }),
          ),
        ],
      ),
    );
  }
}
