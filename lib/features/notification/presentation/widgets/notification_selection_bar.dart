import 'package:flutter/material.dart';

/// Selection bar for notification page with All toggle and delete action
class NotificationSelectionBar extends StatelessWidget {
  final bool isAllSelected;
  final int selectedCount;
  final VoidCallback onAllToggle;
  final VoidCallback onDelete;

  const NotificationSelectionBar({
    super.key,
    required this.isAllSelected,
    required this.selectedCount,
    required this.onAllToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // All checkbox and selected count
          Row(
            children: [
              GestureDetector(
                onTap: onAllToggle,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isAllSelected 
                        ? const Color(0xFF21292B) 
                        : Colors.transparent,
                    border: Border.all(
                      color: isAllSelected 
                          ? const Color(0xFF21292B) 
                          : const Color(0xFFD7D7D7),
                      width: 2,
                    ),
                  ),
                  child: isAllSelected
                      ? const Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'All',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$selectedCount Selected',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7F7F7F),
                ),
              ),
            ],
          ),
          // Delete button
          GestureDetector(
            onTap: selectedCount > 0 ? onDelete : null,
            child: Icon(
              Icons.delete_outline,
              size: 24,
              color: selectedCount > 0 
                  ? const Color(0xFF767676) 
                  : const Color(0xFFD7D7D7),
            ),
          ),
        ],
      ),
    );
  }
}
