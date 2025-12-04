import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;

  const SearchAppBar({
    super.key,
    this.onBackPressed,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          GestureDetector(
            onTap: onBackPressed ?? () => Navigator.of(context).pop(),
            child: Container(
              width: 44,
              height: 44,
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
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Colors.black,
              ),
            ),
          ),
          // Title
          const Text(
            'Search',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          // Menu button
          GestureDetector(
            onTap: onMenuPressed,
            child: Container(
              width: 44,
              height: 44,
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
              child: const Icon(
                Icons.more_horiz,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
