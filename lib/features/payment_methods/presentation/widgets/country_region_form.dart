import 'package:flutter/material.dart';

/// Country and region form section
class CountryRegionForm extends StatelessWidget {
  final String selectedCountry;
  final TextEditingController zipController;
  final VoidCallback onCountryTap;

  const CountryRegionForm({
    super.key,
    required this.selectedCountry,
    required this.zipController,
    required this.onCountryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        const Text(
          'Country or region',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF000000),
          ),
        ),
        const SizedBox(height: 12),

        // Country dropdown
        GestureDetector(
          onTap: onCountryTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFEDEDED),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedCountry,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF7F7F7F),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ZIP field
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFFEDEDED),
              width: 1,
            ),
          ),
          child: TextField(
            controller: zipController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'ZIP',
              hintStyle: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF7F7F7F),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF000000),
            ),
          ),
        ),
      ],
    );
  }
}
