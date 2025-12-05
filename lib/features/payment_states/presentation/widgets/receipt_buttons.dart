import 'package:flutter/material.dart';

/// Receipt action buttons (Download and Share)
class ReceiptButtons extends StatelessWidget {
  final VoidCallback onDownload;
  final VoidCallback onShare;
  final bool isDownloading;
  final bool isSharing;

  const ReceiptButtons({
    super.key,
    required this.onDownload,
    required this.onShare,
    this.isDownloading = false,
    this.isSharing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Download Receipt Button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: isDownloading ? null : onDownload,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFD7D7D7)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
            ),
            child: isDownloading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF7F7F7F),
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.download_outlined,
                        size: 20,
                        color: Color(0xFF7F7F7F),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Download Receipt',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF7F7F7F),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 12),
        // Share Receipt Button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: isSharing ? null : onShare,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFD7D7D7)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
            ),
            child: isSharing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF7F7F7F),
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share_outlined,
                        size: 20,
                        color: Color(0xFF7F7F7F),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Shar Your Receipt',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF7F7F7F),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
