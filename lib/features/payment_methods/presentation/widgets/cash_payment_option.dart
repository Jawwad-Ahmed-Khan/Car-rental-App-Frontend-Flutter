import 'package:flutter/material.dart';

/// Cash payment option with default badge
class CashPaymentOption extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const CashPaymentOption({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF21292B)
                : const Color(0xFFEDEDED),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Wallet icon
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF7F7F7F),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.account_balance_wallet_outlined,
                size: 16,
                color: Color(0xFF7F7F7F),
              ),
            ),
            const SizedBox(width: 12),
            // Text
            const Expanded(
              child: Text(
                'Cash payment',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF7F7F7F),
                ),
              ),
            ),
            // Default badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'DAFULT',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xFF7F7F7F),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
