import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/car.dart';
import '../../../filter/domain/entities/filter_criteria.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class SearchInitial extends SearchState {
  const SearchInitial();
}

/// Loading state
class SearchLoading extends SearchState {
  const SearchLoading();
}

/// Loaded state with data
class SearchLoaded extends SearchState {
  final List<Car> recommendedCars;
  final List<Car> popularCars;
  final List<Car> filteredCars;
  final String? selectedBrand;
  final String searchQuery;
  final FilterCriteria? activeFilterCriteria;

  const SearchLoaded({
    required this.recommendedCars,
    required this.popularCars,
    required this.filteredCars,
    this.selectedBrand,
    this.searchQuery = '',
    this.activeFilterCriteria,
  });

  bool get isFilterActive => activeFilterCriteria != null && 
      activeFilterCriteria!.hasActiveFilters;

  SearchLoaded copyWith({
    List<Car>? recommendedCars,
    List<Car>? popularCars,
    List<Car>? filteredCars,
    String? selectedBrand,
    String? searchQuery,
    FilterCriteria? activeFilterCriteria,
    bool clearFilter = false,
  }) {
    return SearchLoaded(
      recommendedCars: recommendedCars ?? this.recommendedCars,
      popularCars: popularCars ?? this.popularCars,
      filteredCars: filteredCars ?? this.filteredCars,
      selectedBrand: selectedBrand ?? this.selectedBrand,
      searchQuery: searchQuery ?? this.searchQuery,
      activeFilterCriteria: clearFilter ? null : (activeFilterCriteria ?? this.activeFilterCriteria),
    );
  }

  @override
  List<Object?> get props => [
        recommendedCars,
        popularCars,
        filteredCars,
        selectedBrand,
        searchQuery,
        activeFilterCriteria,
      ];
}

/// Error state
class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

