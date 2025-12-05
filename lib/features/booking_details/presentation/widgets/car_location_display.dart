import 'package:flutter/material.dart';

/// Display widget for car location with icon
class CarLocationDisplay extends StatelessWidget {
  final String location;

  const CarLocationDisplay({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Car Location',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFD7D7D7)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: Color(0xFF767676),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  location,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5A5A5A),
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
