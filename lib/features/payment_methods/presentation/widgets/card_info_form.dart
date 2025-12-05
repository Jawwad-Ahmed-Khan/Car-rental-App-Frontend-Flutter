import 'package:flutter/material.dart';

/// Card information form section
class CardInfoForm extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController cardNumberController;
  final TextEditingController expiryController;
  final TextEditingController cvcController;

  const CardInfoForm({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.cardNumberController,
    required this.expiryController,
    required this.cvcController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        const Text(
          'Card information',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF000000),
          ),
        ),
        const SizedBox(height: 12),

        // Full Name field
        _buildTextField(
          controller: fullNameController,
          hint: 'Full Name',
        ),
        const SizedBox(height: 12),

        // Email Address field
        _buildTextField(
          controller: emailController,
          hint: 'Email Address',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),

        // Card Number field with card icons
        _buildCardNumberField(),
        const SizedBox(height: 12),

        // Expiry and CVC row
        Row(
          children: [
            // MM / YY field
            Expanded(
              child: _buildTextField(
                controller: expiryController,
                hint: 'MM / YY',
              ),
            ),
            const SizedBox(width: 12),
            // CVC field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFEDEDED),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: cvcController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'CVC',
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFF7F7F7F),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(
                        Icons.credit_card,
                        size: 20,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFEDEDED),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF7F7F7F),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color(0xFF000000),
        ),
      ),
    );
  }

  Widget _buildCardNumberField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFEDEDED),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Number',
                hintStyle: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF7F7F7F),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF000000),
              ),
            ),
          ),
          // Card type icons
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCardIcon('VISA', const Color(0xFF1A1F71)),
                const SizedBox(width: 4),
                _buildMastercardMini(),
                const SizedBox(width: 4),
                _buildCardIcon('AMEX', const Color(0xFF006FCF)),
                const SizedBox(width: 4),
                Icon(
                  Icons.credit_card,
                  size: 18,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardIcon(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
          fontSize: 6,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMastercardMini() {
    return SizedBox(
      width: 20,
      height: 14,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEB001B),
              ),
            ),
          ),
          Positioned(
            left: 6,
            child: Container(
              width: 12,
              height: 12,
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
}
