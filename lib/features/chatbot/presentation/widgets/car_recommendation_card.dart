import 'package:flutter/material.dart';
import '../../domain/entities/chat_message.dart';

/// Widget for displaying a car recommendation card in chat
class CarRecommendationCard extends StatelessWidget {
  final ChatMessage message;

  const CarRecommendationCard({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final car = message.carRecommendation;
    if (car == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bot text message
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message.text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Car card
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    color: const Color(0xFFFFF9E6),
                    child: Image.asset(
                      car.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.directions_car,
                          size: 60,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Car name and rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              car.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                car.rating.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Location
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            car.location,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Seats and price
                      Row(
                        children: [
                          const Icon(
                            Icons.event_seat_outlined,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${car.seats} Seats',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.attach_money,
                            size: 14,
                            color: Colors.grey,
                          ),
                          Text(
                            '\$${car.pricePerDay.toInt()}/Day',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Book Now button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Navigate to booking
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2C2C2C),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Book Now',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Also available section
          if (car.alsoAvailable != null) ...[
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                'Also available:',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildAlsoAvailableCard(car),
          ],
        ],
      ),
    );
  }

  Widget _buildAlsoAvailableCard(CarRecommendation car) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 60,
              height: 40,
              color: const Color(0xFFF5F5F5),
              child: Image.asset(
                car.alsoAvailableImage ?? '',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.directions_car,
                    size: 24,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                car.alsoAvailable ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    (car.alsoAvailableRating ?? 5.0).toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 12,
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
