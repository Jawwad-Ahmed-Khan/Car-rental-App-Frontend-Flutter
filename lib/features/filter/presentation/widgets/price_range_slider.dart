import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Widget for selecting price range with histogram visualization
class PriceRangeSlider extends StatelessWidget {
  final double minPrice;
  final double maxPrice;
  final double rangeMin;
  final double rangeMax;
  final ValueChanged<RangeValues> onChanged;

  const PriceRangeSlider({
    super.key,
    required this.minPrice,
    required this.maxPrice,
    this.rangeMin = 10,
    this.rangeMax = 230,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Price range',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          // Histogram visualization
          SizedBox(
            height: 60,
            child: CustomPaint(
              size: const Size(double.infinity, 60),
              painter: HistogramPainter(
                minValue: minPrice,
                maxValue: maxPrice,
                rangeMin: rangeMin,
                rangeMax: rangeMax,
              ),
            ),
          ),
          // Range Slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF21292B),
              inactiveTrackColor: const Color(0xFFD7D7D7),
              thumbColor: Colors.white,
              overlayColor: const Color(0x2921292B),
              trackHeight: 2,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 12,
                elevation: 4,
              ),
            ),
            child: RangeSlider(
              values: RangeValues(minPrice, maxPrice),
              min: rangeMin,
              max: rangeMax,
              onChanged: onChanged,
            ),
          ),
          const SizedBox(height: 10),
          // Price labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Minimum',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      color: Color(0xFF7F7F7F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD7D7D7)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '\$${minPrice.toInt()}',
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Maximum',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      color: Color(0xFF7F7F7F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD7D7D7)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '\$${maxPrice.toInt()}+',
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Custom painter for the histogram visualization
class HistogramPainter extends CustomPainter {
  final double minValue;
  final double maxValue;
  final double rangeMin;
  final double rangeMax;

  HistogramPainter({
    required this.minValue,
    required this.maxValue,
    required this.rangeMin,
    required this.rangeMax,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42); // Fixed seed for consistent bars
    const barCount = 30;
    final barWidth = size.width / barCount - 2;
    
    for (int i = 0; i < barCount; i++) {
      final barHeight = 20 + random.nextDouble() * 40;
      final x = i * (barWidth + 2);
      final barPosition = rangeMin + (i / barCount) * (rangeMax - rangeMin);
      
      final isInRange = barPosition >= minValue && barPosition <= maxValue;
      
      final paint = Paint()
        ..color = isInRange 
            ? const Color(0xFF21292B)
            : const Color(0xFFE0E0E0);
      
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, size.height - barHeight, barWidth, barHeight),
        const Radius.circular(2),
      );
      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant HistogramPainter oldDelegate) {
    return oldDelegate.minValue != minValue || 
           oldDelegate.maxValue != maxValue;
  }
}
