import 'package:flutter/material.dart';

/// Reusable text field with icon prefix for booking form
class BookingTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final String value;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final bool isRequired;
  final bool readOnly;

  const BookingTextField({
    super.key,
    required this.hint,
    required this.icon,
    required this.value,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.isRequired = true,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: readOnly ? const Color(0xFFF5F5F5) : Colors.white,
        border: Border.all(color: const Color(0xFFD7D7D7)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: TextEditingController(text: value)
          ..selection = TextSelection.fromPosition(
            TextPosition(offset: value.length),
          ),
        onChanged: onChanged,
        keyboardType: keyboardType,
        readOnly: readOnly,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: isRequired ? '$hint*' : hint,
          hintStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF5A5A5A),
          ),
          prefixIcon: Icon(icon, color: const Color(0xFF767676), size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
