# Car Detail Feature - Complete Interview Preparation Guide 🚗

> **Purpose**: This guide prepares you for a Flutter developer interview. It covers all concepts, packages, architecture, issues, and solutions for the Car Detail feature.

---

## 📋 Table of Contents

1. [Quick Overview](#1-quick-overview)
2. [Packages & Dependencies](#2-packages--dependencies)
3. [Clean Architecture Deep Dive](#3-clean-architecture-deep-dive)
4. [Folder Structure & Purpose](#4-folder-structure--purpose)
5. [Domain Layer Explained](#5-domain-layer-explained)
6. [Data Layer Explained](#6-data-layer-explained)
7. [Presentation Layer Explained](#7-presentation-layer-explained)
8. [Flutter Widgets Used](#8-flutter-widgets-used)
9. [State Management](#9-state-management)
10. [Navigation System](#10-navigation-system)
11. [Issues Faced & Solutions](#11-issues-faced--solutions)
12. [Interview Q&A](#12-interview-qa)

---

## 1. Quick Overview

### What is Car Detail Feature?
A page that displays comprehensive information about a rental car when user taps on a car card.

### What it shows:
- **Image Carousel**: Swipeable car images with dot indicators
- **Car Info**: Model name, rating, description
- **Owner Section**: Owner avatar, name, verified badge, call/message buttons
- **Features Grid**: 6 features (seats, speed, engine, etc.)
- **Reviews**: Horizontal scrollable review cards
- **Book Now Button**: Sticky bottom button

### Why Clean Architecture?
```
Interview Answer: "I chose Clean Architecture because it:
1. Separates concerns - UI, business logic, and data are independent
2. Makes code testable - each layer can be unit tested
3. Enables maintainability - change database without touching UI
4. Follows SOLID principles - each class has single responsibility"
```

---

## 2. Packages & Dependencies

### Core Package Used

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
```

### Package: `flutter/material.dart`

**What it provides:**

| Component | Usage in Car Detail |
|-----------|---------------------|
| `Scaffold` | Page structure with appBar and body |
| `AppBar` | Top navigation bar |
| `Container` | Box model for styling |
| `Column` | Vertical layout |
| `Row` | Horizontal layout |
| `Stack` | Overlay widgets on top of each other |
| `Positioned` | Position widgets inside Stack |
| `PageView` | Swipeable image carousel |
| `GridView` | 2x3 features grid |
| `ListView` | Horizontal reviews scroll |
| `SingleChildScrollView` | Scrollable page content |
| `GestureDetector` | Handle tap events |
| `CircleAvatar` | Round profile images |
| `Icon` | Material icons |
| `Image.asset()` | Load local images |
| `BoxDecoration` | Borders, shadows, colors |
| `BorderRadius` | Rounded corners |
| `EdgeInsets` | Padding and margins |

### How to Use Material Package

```dart
// Import at top of every Dart file that uses UI
import 'package:flutter/material.dart';

// Example usage
Container(
  padding: const EdgeInsets.all(16),  // 16px padding all sides
  margin: const EdgeInsets.symmetric(horizontal: 20),  // 20px left/right
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),  // Rounded corners
    border: Border.all(color: Color(0xFFD7D7D7)),  // Gray border
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),  // 10% opacity
        blurRadius: 10,
        offset: Offset(0, 4),  // Shadow below
      ),
    ],
  ),
  child: Text('Hello'),
)
```

### Why No External Packages?

```
Interview Answer: "For this feature, Flutter's built-in widgets were 
sufficient. I avoided external packages to:
1. Reduce app size
2. Avoid dependency conflicts
3. Have full control over behavior
4. Follow the principle of minimal dependencies"
```

---

## 3. Clean Architecture Deep Dive

### Three Layers Diagram

```
┌──────────────────────────────────────────────────────────────────┐
│                     PRESENTATION LAYER                           │
│  📱 What User Sees                                               │
│  ├── Pages (Screens)                                             │
│  ├── Widgets (UI Components)                                     │
│  └── State Management (setState, BLoC, Provider)                 │
│                                                                   │
│  Dependencies: Can import from Domain Layer                      │
│  Cannot import: Data Layer directly                              │
└────────────────────────────┬─────────────────────────────────────┘
                             │ uses
┌────────────────────────────▼─────────────────────────────────────┐
│                       DOMAIN LAYER                               │
│  🧠 Business Rules (Pure Dart - No Flutter!)                     │
│  ├── Entities (Data Objects)                                     │
│  ├── Use Cases (Business Actions)                                │
│  └── Repository Interfaces (Contracts)                           │
│                                                                   │
│  Dependencies: NONE (completely independent)                     │
│  Cannot import: Flutter, Data Layer                              │
└────────────────────────────┬─────────────────────────────────────┘
                             │ implemented by
┌────────────────────────────▼─────────────────────────────────────┐
│                        DATA LAYER                                │
│  💾 Where Data Comes From                                        │
│  ├── Data Sources (API, Database, Local Storage)                 │
│  ├── Models (JSON parsing, mapping)                              │
│  └── Repository Implementations                                  │
│                                                                   │
│  Dependencies: Can import from Domain Layer                      │
│  Implements: Repository interfaces from Domain                   │
└──────────────────────────────────────────────────────────────────┘
```

### Dependency Rule

```
Interview Answer: "The Dependency Rule states that:
- Outer layers can depend on inner layers
- Inner layers CANNOT depend on outer layers
- Domain Layer is the innermost (no dependencies)
- Data Layer implements Domain interfaces
- Presentation Layer uses Domain entities and use cases"
```

---

## 4. Folder Structure & Purpose

```
lib/features/car_detail/
│
├── domain/                         # 🧠 BUSINESS LOGIC LAYER
│   │
│   ├── entities/                   # 📦 Data Structures
│   │   ├── car_detail.dart        # Main car object with all fields
│   │   ├── owner.dart             # Owner info (id, name, avatar, verified)
│   │   ├── car_feature.dart       # Single feature (icon, title, value)
│   │   └── review.dart            # Review (author, rating, content)
│   │
│   ├── repositories/              # 📝 Contracts (Interfaces)
│   │   └── car_detail_repository.dart  # Abstract class defining methods
│   │
│   └── usecases/                  # ⚡ Business Actions
│       └── get_car_details.dart   # Fetches car by ID
│
├── data/                          # 💾 DATA LAYER
│   │
│   ├── datasources/               # 🔌 Data Origins
│   │   └── car_detail_local_data_source.dart  # Mock data storage
│   │
│   └── repositories/              # 🔧 Implementation
│       └── car_detail_repository_impl.dart    # Implements interface
│
├── presentation/                  # 🎨 UI LAYER
│   │
│   ├── pages/                     # 📄 Full Screens
│   │   └── car_detail_page.dart   # Main page composing all widgets
│   │
│   └── widgets/                   # 🧩 Reusable Components
│       ├── car_detail_app_bar.dart     # Top navigation
│       ├── car_image_carousel.dart     # Image slider
│       ├── car_info_section.dart       # Title, rating, description
│       ├── owner_info_section.dart     # Owner card
│       ├── car_features_grid.dart      # 2x3 grid container
│       ├── car_feature_card.dart       # Single feature box
│       ├── reviews_section.dart        # Reviews header + list
│       ├── review_card.dart            # Single review box
│       └── book_now_button.dart        # Sticky bottom button
│
└── CAR_DETAIL_GUIDE.md            # 📚 This documentation
```

### Purpose of Each Folder

| Folder | Purpose | Interview Explanation |
|--------|---------|----------------------|
| `domain/entities/` | Define data structures | "Entities are plain Dart classes that represent business objects. They have no dependencies on Flutter or external packages." |
| `domain/repositories/` | Define contracts | "Repository interfaces define WHAT operations are available, not HOW they're implemented. This follows Dependency Inversion Principle." |
| `domain/usecases/` | Business actions | "Use cases encapsulate single business operations. They're called by the presentation layer and use repositories to get data." |
| `data/datasources/` | Data origins | "Data sources provide actual data - from API, database, or mock. They handle the 'HOW' of data fetching." |
| `data/repositories/` | Bridge layers | "Repository implementations fulfill the domain contracts using data sources. They convert data to domain entities." |
| `presentation/pages/` | Full screens | "Pages are complete screens that compose multiple widgets. They manage page-level state and lifecycle." |
| `presentation/widgets/` | UI components | "Widgets are reusable UI pieces. Each widget has single responsibility - display one section." |

---

## 5. Domain Layer Explained

### 5.1 Entity: CarDetail

```dart
// File: domain/entities/car_detail.dart

class CarDetail {
  final String id;              // Unique identifier
  final String brand;           // "Ferrari"
  final String model;           // "Ferrari-FF"
  final double price;           // 200.0 (per day)
  final List<String> imageUrls; // Multiple images for carousel
  final double rating;          // 5.0 (out of 5)
  final int reviewCount;        // 120 reviews
  final String description;     // Long text description
  final int seats;              // 4 seats
  final bool isFavorite;        // Heart icon state
  
  // Nested objects - Composition Pattern
  final Owner owner;            // Owner details
  final List<CarFeature> features;  // 6 features
  final List<Review> reviews;   // Review list

  const CarDetail({
    required this.id,
    required this.brand,
    // ... all required parameters
  });
}
```

**Interview Question: Why use `const` constructor?**
```
Answer: "The const constructor allows creating compile-time constants.
When all fields are final and we use const, Flutter can:
1. Reuse the same instance in memory
2. Skip rebuilding widgets with same const values
3. Improve performance by reducing allocations"
```

### 5.2 Repository Interface

```dart
// File: domain/repositories/car_detail_repository.dart

import '../entities/car_detail.dart';

// 'abstract' = Cannot instantiate, must be implemented
abstract class CarDetailRepository {
  // 'Future' = Async operation (might take time)
  Future<CarDetail> getCarDetails(String carId);
}
```

**Interview Question: Why use abstract class?**
```
Answer: "Abstract class creates a contract that:
1. Defines method signatures without implementation
2. Allows multiple implementations (local, remote, test)
3. Enables dependency injection
4. Follows Interface Segregation Principle"
```

### 5.3 Use Case

```dart
// File: domain/usecases/get_car_details.dart

class GetCarDetails {
  final CarDetailRepository repository;

  GetCarDetails(this.repository);  // Dependency Injection

  // 'call' method allows object to be called like function
  Future<CarDetail> call(String carId) async {
    return await repository.getCarDetails(carId);
  }
}

// Usage:
final useCase = GetCarDetails(repository);
final car = await useCase('1');  // Calls call() method
```

**Interview Question: What is a Use Case?**
```
Answer: "A Use Case represents a single business operation.
It:
1. Encapsulates one action (Get Car Details)
2. Receives dependencies via constructor (Dependency Injection)
3. Is called by presentation layer
4. Returns domain entities, not data models"
```

---

## 6. Data Layer Explained

### 6.1 Local Data Source

```dart
// File: data/datasources/car_detail_local_data_source.dart

import 'package:flutter/material.dart';  // For Icons
import '../../domain/entities/car_detail.dart';
// ... other imports

class CarDetailLocalDataSource {
  // Map stores car data by ID
  final Map<String, CarDetail> _mockCarDetails = {
    '1': CarDetail(
      id: '1',
      brand: 'Ferrari',
      model: 'Ferrari-FF',
      price: 200,
      imageUrls: [
        'assets/images/ferrari_car_1.webp',
        'assets/images/ferrari_car_2.webp',
      ],
      // ... more data
    ),
    '2': CarDetail(...),
    '3': CarDetail(...),
    '4': CarDetail(...),
    '5': CarDetail(...),
  };

  Future<CarDetail> getCarDetails(String carId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    final carDetail = _mockCarDetails[carId];
    if (carDetail != null) {
      return carDetail;
    }
    
    // Fallback if ID not found
    return _mockCarDetails.values.first;
  }
}
```

**Interview Question: Why mock data?**
```
Answer: "Mock data allows:
1. Development without backend
2. Testing in isolation
3. Quick prototyping
4. Demonstrating UI without network

In production, we'd replace this with API calls."
```

### 6.2 Repository Implementation

```dart
// File: data/repositories/car_detail_repository_impl.dart

import '../../domain/entities/car_detail.dart';
import '../../domain/repositories/car_detail_repository.dart';
import '../datasources/car_detail_local_data_source.dart';

// 'implements' = fulfills abstract class contract
class CarDetailRepositoryImpl implements CarDetailRepository {
  final CarDetailLocalDataSource localDataSource;

  CarDetailRepositoryImpl({required this.localDataSource});

  @override  // Indicates implementing interface method
  Future<CarDetail> getCarDetails(String carId) async {
    return await localDataSource.getCarDetails(carId);
  }
}
```

**Interview Question: Why separate DataSource and Repository?**
```
Answer: "Separation allows:
1. Repository can combine multiple data sources (local + remote)
2. Easy to add caching logic in repository
3. Data source handles only data fetching
4. Repository handles data mapping and business logic"
```

---

## 7. Presentation Layer Explained

### 7.1 Main Page (StatefulWidget)

```dart
// File: presentation/pages/car_detail_page.dart

class CarDetailPage extends StatefulWidget {
  final String carId;  // Received from navigation

  const CarDetailPage({super.key, required this.carId});

  @override
  State<CarDetailPage> createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  // 'late' = initialized after declaration, before use
  late final GetCarDetails _getCarDetails;
  
  // '?' = nullable, can be null initially
  CarDetail? _carDetail;
  bool _isLoading = true;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _initializeAndLoad();
  }

  void _initializeAndLoad() {
    // Dependency Injection - Manual wiring
    final dataSource = CarDetailLocalDataSource();
    final repository = CarDetailRepositoryImpl(localDataSource: dataSource);
    _getCarDetails = GetCarDetails(repository);
    _loadCarDetails();
  }

  Future<void> _loadCarDetails() async {
    try {
      // widget.carId accesses StatefulWidget property
      final carDetail = await _getCarDetails(widget.carId);
      setState(() {
        _carDetail = carDetail;
        _isFavorite = carDetail.isFavorite;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CarDetailAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _carDetail == null
              ? const Center(child: Text('Car not found'))
              : _buildContent(),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CarImageCarousel(imageUrls: _carDetail!.imageUrls),
                CarInfoSection(model: _carDetail!.model, ...),
                OwnerInfoSection(owner: _carDetail!.owner),
                CarFeaturesGrid(features: _carDetail!.features),
                ReviewsSection(reviews: _carDetail!.reviews),
              ],
            ),
          ),
        ),
        BookNowButton(onPressed: () {}),
      ],
    );
  }
}
```

### 7.2 Widget Breakdown

| Widget | Type | Purpose |
|--------|------|---------|
| `CarDetailPage` | StatefulWidget | Manages loading state and data |
| `CarDetailAppBar` | StatelessWidget | Back button, title, menu |
| `CarImageCarousel` | StatefulWidget | Tracks current image page |
| `CarInfoSection` | StatelessWidget | Displays model, rating |
| `OwnerInfoSection` | StatelessWidget | Shows owner details |
| `CarFeaturesGrid` | StatelessWidget | 2x3 grid of features |
| `CarFeatureCard` | StatelessWidget | Single feature display |
| `ReviewsSection` | StatelessWidget | Horizontal review list |
| `ReviewCard` | StatelessWidget | Single review card |
| `BookNowButton` | StatelessWidget | Bottom action button |

---

## 8. Flutter Widgets Used

### Layout Widgets

```dart
// Scaffold - Basic page structure
Scaffold(
  appBar: AppBar(...),
  body: Container(...),
)

// Column - Vertical arrangement
Column(
  crossAxisAlignment: CrossAxisAlignment.start,  // Align left
  children: [Widget1(), Widget2()],
)

// Row - Horizontal arrangement
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Space out
  children: [Widget1(), Widget2()],
)

// Stack - Overlay widgets
Stack(
  children: [
    Image(...),           // Bottom layer
    Positioned(           // Overlay on top
      top: 16, right: 16,
      child: Icon(...),
    ),
  ],
)

// SingleChildScrollView - Scrollable content
SingleChildScrollView(
  child: Column(children: [...]),
)
```

### List Widgets

```dart
// GridView - 2D grid layout
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,       // 3 columns
    crossAxisSpacing: 12,    // Horizontal gap
    mainAxisSpacing: 12,     // Vertical gap
    childAspectRatio: 1.0,   // Square items
  ),
  itemCount: 6,
  itemBuilder: (context, index) => CarFeatureCard(...),
)

// ListView - Scrollable list
ListView.builder(
  scrollDirection: Axis.horizontal,  // Swipe left/right
  itemCount: reviews.length,
  itemBuilder: (context, index) => ReviewCard(...),
)

// PageView - Swipeable pages
PageView.builder(
  controller: _pageController,
  physics: const ClampingScrollPhysics(),
  onPageChanged: (index) => setState(() => _currentPage = index),
  itemBuilder: (context, index) => Image.asset(...),
)
```

### Input Widgets

```dart
// GestureDetector - Handle taps
GestureDetector(
  onTap: () => Navigator.pop(context),
  child: Icon(Icons.arrow_back),
)

// ElevatedButton - Material button
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF21292B),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  child: Text('Book Now'),
)
```

---

## 9. State Management

### Using setState (Current Approach)

```dart
class _CarDetailPageState extends State<CarDetailPage> {
  bool _isLoading = true;
  CarDetail? _carDetail;

  void _loadData() async {
    final data = await fetchData();
    setState(() {  // Triggers rebuild
      _carDetail = data;
      _isLoading = false;
    });
  }
}
```

**Interview Question: When to use setState?**
```
Answer: "setState is suitable when:
1. State is local to one widget
2. Widget tree is not deeply nested
3. State changes are simple
4. No shared state between components

For complex apps, use BLoC, Provider, or Riverpod."
```

### Widget Lifecycle

```dart
class _CarImageCarouselState extends State<CarImageCarousel> {
  late PageController _pageController;

  @override
  void initState() {  // Called once, widget created
    super.initState();
    _pageController = PageController();
  }

  @override
  void didUpdateWidget(CarImageCarousel oldWidget) {  // Props changed
    super.didUpdateWidget(oldWidget);
    // React to changes
  }

  @override
  void dispose() {  // Widget removed, cleanup
    _pageController.dispose();  // Prevent memory leak!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {  // Build UI
    return PageView.builder(...);
  }
}
```

---

## 10. Navigation System

### Router Setup

```dart
// File: lib/routes/app_router.dart

class AppRouter {
  static const String carDetails = '/car_details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case carDetails:
        // Extract arguments
        final args = settings.arguments as Map<String, dynamic>?;
        final carId = args?['carId'] as String? ?? '1';
        return MaterialPageRoute(
          builder: (_) => CarDetailPage(carId: carId),
        );
      // ... other routes
    }
  }
}
```

### Navigation from CarCard

```dart
// File: home/presentation/widgets/car_card.dart

GestureDetector(
  onTap: () {
    Navigator.pushNamed(
      context,
      AppRouter.carDetails,
      arguments: {'carId': car.id},  // Pass data
    );
  },
  child: Container(...),
)
```

**Interview Question: Explain the navigation flow**
```
Answer: "When user taps a car card:
1. GestureDetector catches tap event
2. Navigator.pushNamed called with route name and arguments
3. AppRouter.generateRoute matches route name
4. Arguments extracted from RouteSettings
5. CarDetailPage created with carId parameter
6. New page pushed onto navigation stack"
```

---

## 11. Issues Faced & Solutions

### Issue 1: Images Not Loading

**Symptom**: Placeholder car icon shown instead of actual image

**Cause**: Used `.avif` image format not supported on Windows

**Solution**:
```dart
// Changed from:
imageUrls: ['assets/images/car.avif']

// To:
imageUrls: ['assets/images/car.png']
```

**Prevention**: Use widely supported formats (PNG, JPG, WebP)

---

### Issue 2: Carousel Not Swiping

**Symptom**: PageView doesn't respond to horizontal swipe gestures

**Cause**: Gesture conflict with parent `SingleChildScrollView` (both want vertical/horizontal gestures)

**Solution**:
```dart
// Added explicit physics
PageView.builder(
  physics: const ClampingScrollPhysics(),
  scrollDirection: Axis.horizontal,
  // ...
)
```

**Explanation**: `ClampingScrollPhysics` gives PageView priority for horizontal gestures

---

### Issue 3: Wrong Car Details Shown

**Symptom**: All cars show same details (first car)

**Cause**: Mock data IDs didn't match home page car IDs

**Root Cause Analysis**:
```dart
// Home page had:
CarModel(id: '1', brand: 'Ferrari', ...),
CarModel(id: '2', brand: 'Tesla', ...),
CarModel(id: '3', brand: 'BMW', ...),
CarModel(id: '4', brand: 'Lamborghini', ...),
CarModel(id: '5', brand: 'Toyota', ...),

// Car detail mock data only had:
'1': CarDetail(...),  // Tesla (wrong!)
'2': CarDetail(...),  // BMW

// When user clicked Ferrari (id='1'), got fallback
```

**Solution**: Added all 5 cars with matching IDs and data

---

### Issue 4: Deprecated `withOpacity`

**Symptom**: Analyzer warning about deprecated method

**Cause**: `Color.withOpacity()` deprecated in Flutter 3.18+

**Solution**:
```dart
// Changed from:
Colors.black.withOpacity(0.3)

// To:
Colors.black.withValues(alpha: 0.3)
```

---

## 12. Interview Q&A

### Architecture Questions

**Q: What is Clean Architecture?**
```
A: Clean Architecture separates app into layers:
- Presentation (UI)
- Domain (business logic)
- Data (data sources)

Each layer has single responsibility and dependencies flow inward.
```

**Q: Why use repository pattern?**
```
A: Repository pattern:
1. Abstracts data source from business logic
2. Enables easy testing with mock repositories
3. Allows switching data sources without changing UI
4. Follows Dependency Inversion Principle
```

**Q: What is Dependency Injection?**
```
A: Passing dependencies via constructor instead of creating inside class.

// Without DI (bad):
class GetCarDetails {
  final repository = CarDetailRepositoryImpl();  // Hardcoded!
}

// With DI (good):
class GetCarDetails {
  final CarDetailRepository repository;
  GetCarDetails(this.repository);  // Injected!
}
```

### Flutter Questions

**Q: Difference between StatelessWidget and StatefulWidget?**
```
A: 
- StatelessWidget: Immutable, no internal state, build() called once
- StatefulWidget: Has State object, can change, setState() triggers rebuild
```

**Q: What is BuildContext?**
```
A: BuildContext is widget's location in the widget tree.
Used to:
- Access inherited widgets (Theme, MediaQuery)
- Navigate
- Show dialogs/snackbars
```

**Q: What is `const` keyword?**
```
A: const creates compile-time constants.
Benefits:
- Widget reused from memory
- Skips rebuild if props same
- Better performance
```

**Q: Explain Widget lifecycle**
```
A: 
1. createState() - Create State object
2. initState() - Initialize (fetch data, setup controllers)
3. build() - Create widget tree
4. setState() - Mark for rebuild
5. didUpdateWidget() - Parent rebuilt with new data
6. dispose() - Cleanup (dispose controllers, cancel subscriptions)
```

### Code Questions

**Q: What does `late` keyword do?**
```
A: late tells Dart variable will be initialized before use.
Used when:
- Can't initialize in declaration
- Will initialize in initState()
- Want lazy initialization
```

**Q: What does `?` mean in type?**
```
A: Nullable type. CarDetail? can be CarDetail or null.
Used for:
- Optional values
- Loading states (null before data arrives)
- Error handling
```

**Q: What does `!` mean after variable?**
```
A: Null assertion. Tells Dart "I guarantee this isn't null".
Example: _carDetail!.model
Use carefully - throws error if null!
```

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────────────┐
│                    CAR DETAIL FEATURE                           │
├─────────────────────────────────────────────────────────────────┤
│  Architecture: Clean Architecture (3 layers)                   │
│  State Management: setState                                     │
│  Navigation: Named routes with arguments                        │
│  Packages: flutter/material.dart only                          │
├─────────────────────────────────────────────────────────────────┤
│  Files Created: 13 files                                        │
│  - Domain: 6 files (entities, repository, usecase)             │
│  - Data: 2 files (datasource, repository impl)                 │
│  - Presentation: 10 files (page, 9 widgets)                    │
├─────────────────────────────────────────────────────────────────┤
│  Key Widgets Used:                                              │
│  - Scaffold, Column, Row, Stack, Container                     │
│  - PageView (carousel), GridView (features), ListView (reviews)│
│  - GestureDetector (taps), ElevatedButton (book now)           │
├─────────────────────────────────────────────────────────────────┤
│  Issues Fixed:                                                  │
│  1. .avif images → .png/.webp                                  │
│  2. Carousel gesture → ClampingScrollPhysics                   │
│  3. Wrong car data → Match IDs                                 │
│  4. withOpacity deprecated → withValues(alpha:)                │
└─────────────────────────────────────────────────────────────────┘
```

---

**Good luck with your interview! 🎯**
