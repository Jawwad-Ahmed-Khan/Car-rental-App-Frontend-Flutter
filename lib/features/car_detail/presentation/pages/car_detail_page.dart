import 'package:flutter/material.dart';
import '../../../../features/profile/domain/repositories/profile_repository.dart';
import '../../../../di/injection_container.dart';
import '../../domain/entities/car_detail.dart';
import '../../domain/usecases/get_car_details.dart';
import '../widgets/car_detail_app_bar.dart';
import '../widgets/car_image_carousel.dart';
import '../widgets/car_info_section.dart';
import '../widgets/owner_info_section.dart';
import '../widgets/car_features_grid.dart';
import '../widgets/reviews_section.dart';
import '../widgets/book_now_button.dart';
import '../../../../routes/app_router.dart';

/// Main Car Details page
class CarDetailPage extends StatefulWidget {
  final String carId;

  const CarDetailPage({super.key, required this.carId});

  @override
  State<CarDetailPage> createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  late final GetCarDetails _getCarDetails;
  late final ProfileRepository _profileRepository;
  CarDetail? _carDetail;
  bool _isLoading = true;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Use GetIt to retrieve the use case
    _getCarDetails = sl<GetCarDetails>();
    _profileRepository = sl<ProfileRepository>();
    _loadCarDetails();
  }

  Future<void> _loadCarDetails() async {
    try {
      final carDetail = await _getCarDetails(widget.carId);
      final isFav = await _profileRepository.isFavorite(widget.carId);

      setState(() {
        _carDetail = carDetail;
        _isFavorite = isFav;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading details: $e')));
      }
    }
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    try {
      if (_isFavorite) {
        await _profileRepository.addFavorite(widget.carId);
      } else {
        await _profileRepository.removeFavorite(widget.carId);
      }
    } catch (e) {
      // Revert state on error
      setState(() {
        _isFavorite = !_isFavorite;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update favorite: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CarDetailAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _carDetail == null
          ? const Center(child: Text('Car not found'))
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Carousel
                        CarImageCarousel(
                          imageUrls: _carDetail!.imageUrls,
                          isFavorite: _isFavorite,
                          onFavoritePressed: _toggleFavorite,
                        ),
                        const SizedBox(height: 20),

                        // Car Info Section
                        CarInfoSection(
                          model: _carDetail!.model,
                          rating: _carDetail!.rating,
                          reviewCount: _carDetail!.reviewCount,
                          description: _carDetail!.description,
                        ),
                        const SizedBox(height: 20),

                        // Divider
                        const Divider(height: 1, color: Color(0xFFEDEDED)),
                        const SizedBox(height: 20),

                        // Owner Info Section
                        OwnerInfoSection(
                          owner: _carDetail!.owner,
                          onCallPressed: () {
                            // Handle call
                          },
                          onMessagePressed: () {
                            // Handle message
                          },
                        ),
                        const SizedBox(height: 24),

                        // Car Features Grid
                        if (_carDetail!.features.isNotEmpty) ...[
                          CarFeaturesGrid(features: _carDetail!.features),
                          const SizedBox(height: 24),
                        ],

                        // Reviews Section
                        if (_carDetail!.reviews.isNotEmpty) ...[
                          ReviewsSection(
                            reviews: _carDetail!.reviews,
                            totalReviewCount: _carDetail!.reviewCount,
                            onSeeAllPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRouter.reviews,
                                arguments: {
                                  'carId': widget.carId,
                                  'rating': _carDetail!.rating,
                                  'reviewCount': _carDetail!.reviewCount,
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ],
                    ),
                  ),
                ),

                // Book Now Button
                BookNowButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouter.bookingDetails,
                      arguments: {
                        'carId': widget.carId,
                        'price': _carDetail!.price,
                        'carName': _carDetail!.model,
                        'carImageUrl': _carDetail!.imageUrls.isNotEmpty
                            ? _carDetail!.imageUrls.first
                            : '',
                      },
                    );
                  },
                ),
              ],
            ),
    );
  }
}
