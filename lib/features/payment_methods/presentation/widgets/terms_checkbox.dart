import 'package:flutter/material.dart';

/// Terms and continue checkbox widget
class TermsCheckbox extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onChanged;

  const TermsCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Checkbox
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isChecked ? const Color(0xFF21292B) : Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isChecked
                    ? const Color(0xFF21292B)
                    : const Color(0xFFD7D7D7),
                width: 1.5,
              ),
            ),
            child: isChecked
                ? const Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 10),
          // Text with dropdown arrow
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Trams & continue',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF000000),
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                size: 18,
                color: Color(0xFF7F7F7F),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
