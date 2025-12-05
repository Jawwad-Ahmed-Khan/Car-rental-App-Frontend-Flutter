import 'package:flutter/material.dart';
import '../../domain/entities/payment_method.dart';

/// Widget for individual payment method option
class PaymentOptionItem extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOptionItem({
    super.key,
    required this.paymentMethod,
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
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
                ? const Color(0xFF21292B) 
                : const Color(0xFFD7D7D7),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Payment method icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: _buildPaymentIcon(),
              ),
            ),
            const SizedBox(width: 16),

            // Payment method name
            Expanded(
              child: Text(
                paymentMethod.name,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF000000),
                ),
              ),
            ),

            // Radio button
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected 
                      ? const Color(0xFF21292B) 
                      : const Color(0xFFD7D7D7),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF21292B),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentIcon() {
    IconData iconData;
    Color iconColor;

    switch (paymentMethod.type) {
      case PaymentMethodType.applePay:
        iconData = Icons.apple;
        iconColor = const Color(0xFF000000);
        break;
      case PaymentMethodType.googlePay:
        iconData = Icons.g_mobiledata;
        iconColor = const Color(0xFF4285F4);
        break;
      case PaymentMethodType.masterCard:
        iconData = Icons.credit_card;
        iconColor = const Color(0xFFEB001B);
        break;
      case PaymentMethodType.discover:
        iconData = Icons.credit_card;
        iconColor = const Color(0xFFFF6000);
        break;
      case PaymentMethodType.amex:
        iconData = Icons.credit_card;
        iconColor = const Color(0xFF006FCF);
        break;
      default:
        iconData = Icons.payment;
        iconColor = const Color(0xFF454545);
    }

    return Icon(
      iconData,
      size: 28,
      color: iconColor,
    );
  }
}
