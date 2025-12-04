import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search your dream car.....',
          hintStyle: const TextStyle(color: Color(0xFF7F7F7F)), // Text 2
          prefixIcon: const Icon(Icons.search, color: Color(0xFF7F7F7F)),
          suffixIcon: const Icon(Icons.tune, color: Colors.black), // Filter icon
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}
