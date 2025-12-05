import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../di/injection_container.dart';
import '../../../filter/presentation/pages/filter_page.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
import '../widgets/search_app_bar.dart';
import '../widgets/search_input.dart';
import '../widgets/brand_filter_chips.dart';
import '../widgets/search_car_card.dart';
import '../widgets/car_section.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchBloc>()..add(const LoadSearchData()),
      child: const SearchPageContent(),
    );
  }
}

class SearchPageContent extends StatefulWidget {
  const SearchPageContent({super.key});

  @override
  State<SearchPageContent> createState() => _SearchPageContentState();
}

class _SearchPageContentState extends State<SearchPageContent> {
  final TextEditingController _searchController = TextEditingController();

  // Dummy locations for cars
  final List<String> _locations = [
    'Chicago, USA',
    'Washington DC',
    'Washington DC',
    'New York, USA',
    'Los Angeles, USA',
    'Miami, USA',
    'San Francisco, USA',
    'Boston, USA',
  ];

  String _getLocation(int index) {
    return _locations[index % _locations.length];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openFilterPage() async {
    final result = await FilterPage.show(context);
    if (result != null && mounted) {
      context.read<SearchBloc>().add(ApplyFilterCriteria(result));
    }
  }

  void _clearFilters() {
    context.read<SearchBloc>().add(const ApplyFilterCriteria(null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SearchError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is SearchLoaded) {
              return _buildContent(context, state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, SearchLoaded state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // App Bar
          SearchAppBar(
            onBackPressed: () {
              // Pop the navigation stack if we can, otherwise do nothing (tab page)
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          ),
          const SizedBox(height: 15),
          // Divider
          const Divider(color: Color(0xFFD7D7D7), height: 1),
          const SizedBox(height: 20),
          // Search Input with filter button
          SearchInput(
            controller: _searchController,
            onChanged: (query) {
              context.read<SearchBloc>().add(SearchQueryChanged(query));
            },
            onFilterPressed: _openFilterPage,
          ),
          const SizedBox(height: 20),
          // Filter Active Indicator
          if (state.isFilterActive)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF21292B),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.filter_alt, color: Colors.white, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Showing ${state.filteredCars.length} filtered cars',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _clearFilters,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                            color: Color(0xFF21292B),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (state.isFilterActive) const SizedBox(height: 20),
          // Brand Filter Chips
          BrandFilterChips(
            selectedBrand: state.selectedBrand,
            onBrandSelected: (brand) {
              _searchController.clear();
              context.read<SearchBloc>().add(BrandFilterChanged(brand));
            },
          ),
          const SizedBox(height: 25),
          // Recommend For You Section (shows filtered cars)
          CarSection(
            title: state.isFilterActive
                ? 'Filtered Results'
                : 'Recommend For You',
            onViewAllPressed: () {
              // Show all recommended cars by scrolling to see more
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Showing all recommended cars'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: state.filteredCars.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.car_rental,
                            size: 60,
                            color: Color(0xFFD7D7D7),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No cars found',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF7F7F7F),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try adjusting your filters',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF7F7F7F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.72,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                      itemCount: state.filteredCars.length > 4
                          ? 4
                          : state.filteredCars.length,
                      itemBuilder: (context, index) {
                        final car = state.filteredCars[index];
                        return SearchCarCard(
                          car: car,
                          transmission: car.transmission,
                          onFavoritePressed: () {
                            // TODO: Toggle favorite
                          },
                          onBookPressed: () {
                            // TODO: Navigate to booking
                          },
                        );
                      },
                    ),
                  ),
          ),
          const SizedBox(height: 25),
          // Our Popular Cars Section (hidden when filter active)
          if (!state.isFilterActive)
            CarSection(
              title: 'Our Popular Cars',
              onViewAllPressed: () {
                // Show all popular cars by scrolling to see more
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Showing all popular cars'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: state.popularCars.length,
                  itemBuilder: (context, index) {
                    final car = state.popularCars[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index < state.popularCars.length - 1 ? 15 : 0,
                      ),
                      child: SizedBox(
                        width: 160,
                        child: SearchCarCard(
                          car: car,
                          transmission: car.transmission,
                          onFavoritePressed: () {
                            // TODO: Toggle favorite
                          },
                          onBookPressed: () {
                            // TODO: Navigate to booking
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          const SizedBox(height: 100), // Bottom padding for nav bar
        ],
      ),
    );
  }
}
