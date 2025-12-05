# Complete Reviews Page Design Guide for Flutter

This guide covers everything about designing a Reviews Page in Flutter, including architecture, routing, UI components, and business logic.

---

## Table of Contents

1. [Page Description and Flow](#1-page-description-and-flow)
2. [Routing Implementation](#2-routing-implementation)
3. [Required Packages](#3-required-packages)
4. [File and Folder Structure](#4-file-and-folder-structure)
5. [Step-by-Step Page Design](#5-step-by-step-page-design)
6. [Business Logic Implementation](#6-business-logic-implementation)
7. [Full Working Code](#7-full-working-code)

---

## 1. Page Description and Flow

### What is a Review Page?

A **Reviews Page** displays user reviews and ratings for a product, service, or car. It allows users to:
- View all reviews for an item
- See rating summaries (average rating, total count)
- Search/filter reviews
- Read detailed feedback from other users

### UI Structure Flow

```
┌─────────────────────────────────────┐
│          Reviews AppBar             │  ← Start: Back button, Title, Menu
├─────────────────────────────────────┤
│     ⭐ 5.0 Reviews (125)            │  ← Rating Header
├─────────────────────────────────────┤
│  🔍 Find reviews..........          │  ← Search Bar
├─────────────────────────────────────┤
│  ┌─────────────────────────────┐    │
│  │ 👤 Mr. Jack        Today    │    │
│  │ ⭐⭐⭐⭐⭐                    │    │  ← Review List Items
│  │ Great car, loved the...     │    │
│  └─────────────────────────────┘    │
│  ┌─────────────────────────────┐    │
│  │ 👤 Robert      Yesterday    │    │
│  │ ⭐⭐⭐⭐⭐                    │    │
│  │ Smooth ride...              │    │
│  └─────────────────────────────┘    │
├─────────────────────────────────────┤
│        [ Book Now → ]               │  ← Action Button
└─────────────────────────────────────┘
                 ↓
          End: Navigate Back
```

### Required Components

| Component | Purpose |
|-----------|---------|
| **AppBar** | Navigation (back), title, menu options |
| **Rating Header** | Shows overall rating + total count |
| **Search Bar** | Filter reviews by keyword |
| **Review List** | Scrollable list of review cards |
| **Review Card** | Avatar, name, date, stars, text |
| **Action Button** | Primary CTA (Book Now, etc.) |

### UX Patterns Used

1. **Pull-to-refresh** - Reload reviews
2. **Infinite scroll** - Load more reviews as user scrolls
3. **Search with debounce** - Filter without excessive API calls
4. **Skeleton loading** - Show placeholders while loading
5. **Relative dates** - "Today", "Yesterday" instead of timestamps

---

## 2. Routing Implementation

### How Users Navigate to Reviews Page

Users typically reach the Reviews Page from a detail page (Car Detail, Product Detail) by tapping a "See All" link in a reviews preview section.

### Flutter Routing Basics

Flutter uses `Navigator` for page navigation. There are two approaches:

#### Approach 1: Named Routes (Recommended for this app)

```dart
// Define route names in app_router.dart
class AppRouter {
  static const String reviews = '/reviews';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case reviews:
        // Extract arguments passed during navigation
        final args = settings.arguments as Map<String, dynamic>?;
        final carId = args?['carId'] as String? ?? '1';
        final rating = args?['rating'] as double? ?? 5.0;
        final reviewCount = args?['reviewCount'] as int? ?? 0;
        
        return MaterialPageRoute(
          builder: (_) => ReviewsPage(
            carId: carId,
            rating: rating,
            reviewCount: reviewCount,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
```

#### Navigating TO the Reviews Page

```dart
// From car_detail_page.dart - when user taps "See All"
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
```

#### Navigating BACK from Reviews Page

```dart
// In reviews_app_bar.dart
IconButton(
  icon: const Icon(Icons.chevron_left),
  onPressed: () => Navigator.of(context).pop(),
),
```

### Route Registration in MaterialApp

```dart
// In app.dart
MaterialApp(
  onGenerateRoute: AppRouter.generateRoute,
  initialRoute: AppRouter.home,
)
```

### Why Named Routes?

| Benefit | Explanation |
|---------|-------------|
| **Centralized** | All routes defined in one file |
| **Type-safe arguments** | Pass data via `settings.arguments` |
| **Deep linking ready** | Easy to add URL-based navigation |
| **Testable** | Mock navigation in tests |

---

## 3. Required Packages

For this Reviews Page, we use **no external packages** - pure Flutter. Here's why:

### Core Flutter Widgets Used

| Widget | Purpose | Why No External Package |
|--------|---------|------------------------|
| `StatefulWidget` | State management | Simple local state suffices |
| `ListView` | Scrollable list | Built-in, performant |
| `TextField` | Search input | Standard Material widget |
| `CircleAvatar` | User avatars | Built-in image handling |

### When to Consider Packages

| Package | Use When |
|---------|----------|
| `flutter_bloc` | Complex state with multiple events/states |
| `provider` | Sharing state across widget tree |
| `cached_network_image` | Loading remote images with caching |
| `shimmer` | Skeleton loading animations |

### Our Simple State Approach

```dart
class _ReviewsPageState extends State<ReviewsPage> {
  List<Review> _reviews = [];        // All reviews
  List<Review> _filteredReviews = []; // After search filter
  bool _isLoading = true;             // Loading state
  
  // No bloc needed - just setState()
  void _onSearchChanged(String query) {
    setState(() {
      _filteredReviews = _reviews.where((r) => 
        r.content.toLowerCase().contains(query.toLowerCase())
      ).toList();
    });
  }
}
```

---

## 4. File and Folder Structure

```
lib/features/reviews/
├── data/
│   ├── datasources/
│   │   └── reviews_local_data_source.dart
│   └── repositories/
│       └── reviews_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── review.dart
│   ├── repositories/
│   │   └── reviews_repository.dart
│   └── usecases/
│       ├── get_reviews.dart
│       └── search_reviews.dart
└── presentation/
    ├── pages/
    │   └── reviews_page.dart
    └── widgets/
        ├── reviews_app_bar.dart
        ├── reviews_header.dart
        ├── reviews_search_bar.dart
        └── review_list_item.dart
```

### What Belongs in Each File

#### Domain Layer (Business Logic)

| File | Contents |
|------|----------|
| `review.dart` | Review entity class with properties (id, author, rating, content, date) |
| `reviews_repository.dart` | Abstract interface defining data operations |
| `get_reviews.dart` | Use case: fetch all reviews for a car |
| `search_reviews.dart` | Use case: filter reviews by query |

#### Data Layer (Data Handling)

| File | Contents |
|------|----------|
| `reviews_local_data_source.dart` | Mock data, local storage, or cache |
| `reviews_repository_impl.dart` | Concrete implementation of repository |

#### Presentation Layer (UI)

| File | Contents |
|------|----------|
| `reviews_page.dart` | Main page composing all widgets |
| `reviews_app_bar.dart` | Custom AppBar with back button |
| `reviews_header.dart` | Rating summary row |
| `reviews_search_bar.dart` | Search input field |
| `review_list_item.dart` | Single review card widget |

---

## 5. Step-by-Step Page Design

### Step 1: Review Entity

```dart
/// Domain entity representing a review
class Review {
  final String id;
  final String authorName;
  final String authorAvatarUrl;
  final double rating;
  final String content;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.rating,
    required this.content,
    required this.createdAt,
  });

  /// Convert timestamp to human-readable relative time
  String get relativeTime {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays == 0) return 'Today';
    if (difference.inDays == 1) return 'Yesterday';
    if (difference.inDays < 7) return '${difference.inDays} days ago';
    if (difference.inDays < 14) return '1 Week ago';
    if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks Weeks ago';
    }
    return '${(difference.inDays / 30).floor()} Months ago';
  }
}
```

**Purpose:** Encapsulates review data with a computed `relativeTime` property for UX-friendly date display.

---

### Step 2: AppBar (Top Section)

```dart
class ReviewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onMorePressed;

  const ReviewsAppBar({super.key, this.onBackPressed, this.onMorePressed});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,  // Prevents shadow on scroll
      centerTitle: true,
      
      // Back Button
      leading: IconButton(
        icon: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD7D7D7)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.chevron_left, color: Colors.black, size: 24),
        ),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      ),
      
      // Title
      title: const Text(
        'Reviews',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      
      // More Options Button
      actions: [
        IconButton(
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD7D7D7)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.more_horiz, color: Colors.black, size: 20),
          ),
          onPressed: onMorePressed,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
```

**Why this layout:**
- `PreferredSizeWidget` allows using as AppBar in Scaffold
- Back button uses `Navigator.pop()` for standard navigation
- Centered title follows iOS design patterns
- Bordered icons match the app's design system

---

### Step 3: Rating Header

```dart
class ReviewsHeader extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const ReviewsHeader({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Star Icon
          const Icon(
            Icons.star,
            color: Color(0xFFFFA500),  // Orange
            size: 24,
          ),
          const SizedBox(width: 8),
          
          // Rating Text
          Text(
            '${rating.toStringAsFixed(1)} Reviews ($reviewCount)',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
```

**Purpose:** Immediately shows users the overall rating quality, building trust.

---

### Step 4: Search Bar

```dart
class ReviewsSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String hintText;

  const ReviewsSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText = 'Find reviews..........',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFD7D7D7)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,  // Called on every keystroke
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 12,
              color: Color(0xFF7F7F7F),
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 16, right: 12),
              child: Icon(Icons.search, color: Color(0xFF767676), size: 20),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 48,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }
}
```

**Search Logic:**
- `onChanged` fires on every keystroke
- Parent widget filters `_reviews` list based on query
- Results update immediately via `setState()`

---

### Step 5: Review List Item (Rating Stars)

```dart
class ReviewListItem extends StatelessWidget {
  final Review review;

  const ReviewListItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD7D7D7)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Row: Avatar, Name, Date
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(review.authorAvatarUrl),
                onBackgroundImageError: (_, __) {},
                child: review.authorAvatarUrl.isEmpty
                    ? const Icon(Icons.person, size: 20, color: Colors.grey)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  review.authorName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                review.relativeTime,  // "Today", "Yesterday", etc.
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF7F7F7F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Star Rating Row
          Row(
            children: List.generate(5, (index) {
              // Determine if star should be filled
              final isFullStar = index < review.rating.floor();
              final isHalfStar = 
                  index == review.rating.floor() && review.rating % 1 >= 0.5;

              return Icon(
                isFullStar || isHalfStar ? Icons.star : Icons.star_border,
                color: const Color(0xFFFFA500),
                size: 18,
              );
            }),
          ),
          const SizedBox(height: 12),
          
          // Review Content
          Text(
            review.content,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF7F7F7F),
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
```

**Rating Logic:**
- `List.generate(5, ...)` creates exactly 5 star icons
- `review.rating.floor()` determines how many full stars
- Half star support: `review.rating % 1 >= 0.5`

---

### Step 6: Action Button (Book Now)

```dart
Widget _buildBookNowButton() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    decoration: const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color(0x0D000000),  // 5% opacity black
          blurRadius: 10,
          offset: Offset(0, -5),    // Shadow above button
        ),
      ],
    ),
    child: SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            // Handle booking action
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF21292B),  // Dark button
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
```

**Why this approach:**
- `SafeArea` prevents button from going under system UI
- Shadow creates visual separation from content
- Full-width button is thumb-friendly on mobile

---

## 6. Business Logic Implementation

### Data Source (Mock Data)

```dart
class ReviewsLocalDataSource {
  final List<Review> _mockReviews = [
    Review(
      id: 'review1',
      authorName: 'Mr. Jack',
      authorAvatarUrl: 'assets/images/user_avatar.png',
      rating: 5.0,
      content: 'The rental car was clean, reliable, and the service was quick.',
      createdAt: DateTime.now(),
    ),
    Review(
      id: 'review2',
      authorName: 'Robert',
      authorAvatarUrl: 'assets/images/user_avatar.png',
      rating: 5.0,
      content: 'Excellent experience, would rent again!',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    // ... more reviews
  ];

  Future<List<Review>> getReviews(String carId) async {
    await Future.delayed(const Duration(milliseconds: 300));  // Simulate network
    return _mockReviews;
  }

  Future<List<Review>> searchReviews(String carId, String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (query.isEmpty) return _mockReviews;
    
    return _mockReviews.where((review) {
      return review.authorName.toLowerCase().contains(query.toLowerCase()) ||
             review.content.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
```

### Repository

```dart
// Abstract interface (domain layer)
abstract class ReviewsRepository {
  Future<List<Review>> getReviews(String carId);
  Future<List<Review>> searchReviews(String carId, String query);
}

// Concrete implementation (data layer)
class ReviewsRepositoryImpl implements ReviewsRepository {
  final ReviewsLocalDataSource localDataSource;

  ReviewsRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Review>> getReviews(String carId) async {
    return await localDataSource.getReviews(carId);
  }

  @override
  Future<List<Review>> searchReviews(String carId, String query) async {
    return await localDataSource.searchReviews(carId, query);
  }
}
```

### Use Cases

```dart
class GetReviews {
  final ReviewsRepository repository;

  GetReviews(this.repository);

  Future<List<Review>> call(String carId) async {
    return await repository.getReviews(carId);
  }
}

class SearchReviews {
  final ReviewsRepository repository;

  SearchReviews(this.repository);

  Future<List<Review>> call(String carId, String query) async {
    return await repository.searchReviews(carId, query);
  }
}
```

### Where API Integration Would Go

```dart
// Future: Replace ReviewsLocalDataSource with ReviewsRemoteDataSource
class ReviewsRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  ReviewsRemoteDataSource({required this.client, required this.baseUrl});

  Future<List<Review>> getReviews(String carId) async {
    final response = await client.get(
      Uri.parse('$baseUrl/cars/$carId/reviews'),
    );
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Review.fromJson(json)).toList();
    } else {
      throw ServerException('Failed to load reviews');
    }
  }
}

// Update repository to use remote with local fallback
class ReviewsRepositoryImpl implements ReviewsRepository {
  final ReviewsRemoteDataSource remoteDataSource;
  final ReviewsLocalDataSource localDataSource;

  @override
  Future<List<Review>> getReviews(String carId) async {
    try {
      return await remoteDataSource.getReviews(carId);
    } catch (e) {
      // Fallback to local/cached data
      return await localDataSource.getReviews(carId);
    }
  }
}
```

---

## 7. Full Working Code

### Complete `reviews_page.dart`

```dart
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

/// Main Reviews Page - displays all reviews for a car
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
  // Use cases for business logic
  late final GetReviews _getReviews;
  late final SearchReviews _searchReviews;
  
  // UI state
  final TextEditingController _searchController = TextEditingController();
  List<Review> _reviews = [];
  List<Review> _filteredReviews = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeAndLoad();
  }

  /// Initialize dependencies and load data
  void _initializeAndLoad() {
    // Set up clean architecture layers
    final dataSource = ReviewsLocalDataSource();
    final repository = ReviewsRepositoryImpl(localDataSource: dataSource);
    _getReviews = GetReviews(repository);
    _searchReviews = SearchReviews(repository);
    
    // Load reviews
    _loadReviews();
  }

  /// Load all reviews from repository
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

  /// Filter reviews based on search query
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
                
                // Rating Header
                ReviewsHeader(
                  rating: widget.rating,
                  reviewCount: widget.reviewCount,
                ),
                const SizedBox(height: 20),
                
                // Search Bar
                ReviewsSearchBar(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                ),
                const SizedBox(height: 20),
                
                // Reviews List
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
                          separatorBuilder: (_, __) => const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            return ReviewListItem(
                              review: _filteredReviews[index],
                            );
                          },
                        ),
                ),
                
                // Book Now Button
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
              // Handle booking - navigate to booking page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking functionality coming soon!')),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
```

---

## Summary

| Aspect | Implementation |
|--------|----------------|
| **Architecture** | Clean Architecture (Domain → Data → Presentation) |
| **State Management** | Simple `StatefulWidget` with `setState()` |
| **Navigation** | Named routes with `Navigator.pushNamed()` |
| **Routing** | Centralized in `AppRouter` class |
| **Data Flow** | Use Cases → Repository → Data Source |
| **UI Pattern** | Composition of small, focused widgets |
| **API Ready** | Swap `LocalDataSource` for `RemoteDataSource` |

This architecture scales well and makes future API integration simple - just create a `ReviewsRemoteDataSource` and update the repository implementation.
