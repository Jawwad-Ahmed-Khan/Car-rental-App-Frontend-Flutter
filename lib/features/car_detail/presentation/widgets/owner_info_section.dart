import 'package:flutter/material.dart';
import '../../domain/entities/owner.dart';

/// Section displaying owner info with call and message buttons
class OwnerInfoSection extends StatelessWidget {
  final Owner owner;
  final VoidCallback? onCallPressed;
  final VoidCallback? onMessagePressed;

  const OwnerInfoSection({
    super.key,
    required this.owner,
    this.onCallPressed,
    this.onMessagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Owner avatar
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(owner.avatarUrl),
            onBackgroundImageError: (_, __) {},
            child: owner.avatarUrl.isEmpty
                ? const Icon(Icons.person, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 12),
          
          // Owner name and verified badge
          Expanded(
            child: Row(
              children: [
                Text(
                  owner.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                if (owner.isVerified) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Call button
          GestureDetector(
            onTap: onCallPressed,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD7D7D7)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.phone_outlined,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Message button
          GestureDetector(
            onTap: onMessagePressed,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD7D7D7)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.chat_bubble_outline,
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
