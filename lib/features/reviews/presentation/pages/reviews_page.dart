import 'package:flutter/material.dart';
import '../../data/datasources/reviews_local_data_source.dart';
import '../../data/repositories/reviews_repository_impl.dart';
import '../../domain/entities/review.dart';
import '../../domain/usecases/get_reviews.dart';
import '../../domain/usecases/search_reviews.dart';
import '../widgets/reviews_app_bar.dart';
import '../widgets/reviews_header.dart';
import '../widgets/reviews_search_bar.dart';
import '../widgets/review_list_item.dart';
import '../../../../routes/app_router.dart';

/// Reviews page showing all reviews for a car
class ReviewsPage extends StatefulWidget {
  final String carId;
  final double rating;
  final int reviewCount;

  const ReviewsPage({
    super.key,
    required this.carId,
    required this.rating,
    required this.reviewCount,
  });

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  late final GetReviews _getReviews;
  late final SearchReviews _searchReviews;
  final TextEditingController _searchController = TextEditingController();

  List<Review> _reviews = [];
  List<Review> _filteredReviews = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeAndLoad();
  }

  void _initializeAndLoad() {
    final dataSource = ReviewsLocalDataSource();
    final repository = ReviewsRepositoryImpl(localDataSource: dataSource);
    _getReviews = GetReviews(repository);
    _searchReviews = SearchReviews(repository);
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    try {
      final reviews = await _getReviews(widget.carId);
      setState(() {
        _reviews = reviews;
        _filteredReviews = reviews;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _onSearchChanged(String query) async {
    if (query.isEmpty) {
      setState(() {
        _filteredReviews = _reviews;
      });
    } else {
      final results = await _searchReviews(widget.carId, query);
      setState(() {
        _filteredReviews = results;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ReviewsAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 16),
                // Rating header
                ReviewsHeader(
                  rating: widget.rating,
                  reviewCount: widget.reviewCount,
                ),
                const SizedBox(height: 20),
                // Search bar
                ReviewsSearchBar(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                ),
                const SizedBox(height: 20),
                // Reviews list
                Expanded(
                  child: _filteredReviews.isEmpty
                      ? const Center(
                          child: Text(
                            'No reviews found',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF7F7F7F),
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.only(bottom: 20),
                          itemCount: _filteredReviews.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            return ReviewListItem(
                              review: _filteredReviews[index],
                            );
                          },
                        ),
                ),
                // Book Now button
                _buildBookNowButton(),
              ],
            ),
    );
  }

  Widget _buildBookNowButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRouter.bookingDetails,
                arguments: {
                  'carId': widget.carId,
                  'price': 1400.0, // Default price, can be dynamic
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF21292B),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Book Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
