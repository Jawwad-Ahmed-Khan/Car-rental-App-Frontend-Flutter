import 'package:flutter/material.dart';

/// Apple Pay button widget
class ApplePayButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ApplePayButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(
            color: Color(0xFFEDEDED),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.apple,
              color: Color(0xFF000000),
              size: 24,
            ),
            SizedBox(width: 8),
            Text(
              'Apple pay',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Google Pay button widget
class GooglePayButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GooglePayButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(
            color: Color(0xFFEDEDED),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google G logo
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
              child: const Text(
                'G',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF4285F4),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Google Pay',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
