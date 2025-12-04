import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../routes/app_router.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          'assets/images/blacklogo.svg',
          height: 24, // Adjust height as needed to match design
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRouter.notifications);
              },
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: const Icon(Icons.notifications_outlined, color: Colors.black, size: 24),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2C2C2C),
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage('assets/images/user_avatar.png'), // Placeholder
              backgroundColor: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}

