import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterPressed;

  const SearchInput({
    super.key,
    this.controller,
    this.onChanged,
    this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search your dream car....',
          hintStyle: const TextStyle(
            color: Color(0xFF7F7F7F),
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF7F7F7F),
          ),
          suffixIcon: GestureDetector(
            onTap: onFilterPressed,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.tune,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
        ),
      ),
    );
  }
}
