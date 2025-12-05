import 'package:flutter/material.dart';

/// AppBar for the Payment States page
class PaymentStatesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PaymentStatesAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF8F8F8),
      elevation: 0,
      leading: IconButton(
        icon: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD7D7D7)),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Color(0xFF000000),
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Payment States',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Color(0xFF000000),
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD7D7D7)),
            ),
            child: const Icon(
              Icons.more_horiz,
              size: 20,
              color: Color(0xFF000000),
            ),
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
