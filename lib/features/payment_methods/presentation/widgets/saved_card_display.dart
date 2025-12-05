import 'package:flutter/material.dart';
import '../../domain/entities/payment_method.dart';

/// Widget displaying the credit card with Mastercard/Visa branding
class SavedCardDisplay extends StatelessWidget {
  final SavedCard card;

  const SavedCardDisplay({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2C3E50),
            Color(0xFF4A5568),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Mastercard logo and Visa text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Mastercard logo (two overlapping circles)
              _buildMastercardLogo(),
              // Visa text
              const Text(
                'VISA',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Chip icon
          _buildChipIcon(),
          const SizedBox(height: 20),

          // Card holder name and expiry
          Row(
            children: [
              Text(
                card.cardHolderName.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                'Expire: ${card.expiryDate}',
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Card number - show as 9655  9655  9655  9655
          Text(
            '${card.cardNumber}  ${card.cardNumber}  ${card.cardNumber}  ${card.cardNumber}',
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMastercardLogo() {
    return SizedBox(
      width: 50,
      height: 30,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEB001B),
              ),
            ),
          ),
          Positioned(
            left: 16,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF5F00).withAlpha(200),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipIcon() {
    return Container(
      width: 36,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFFD4AF37),
        borderRadius: BorderRadius.circular(4),
      ),
      child: GridView.count(
        crossAxisCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: List.generate(
          6,
          (index) => Container(
            decoration: BoxDecoration(
              color: const Color(0xFFB8860B),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
      ),
    );
  }
}
