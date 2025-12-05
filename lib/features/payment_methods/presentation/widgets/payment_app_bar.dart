import 'package:flutter/material.dart';

/// Custom app bar for Payment Methods page
class PaymentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PaymentAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF8F8F8),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFEDEDED),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF000000),
              size: 16,
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: const Text(
        'Payment methods',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF000000),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFEDEDED),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.more_horiz,
              color: Color(0xFF000000),
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
