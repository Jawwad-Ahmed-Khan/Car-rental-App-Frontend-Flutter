import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../filter/domain/entities/filter_criteria.dart';
import '../../../home/domain/entities/car.dart';
import '../../domain/repositories/search_repository.dart';
import '../../../profile/domain/repositories/profile_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository repository;
  final ProfileRepository profileRepository;

  SearchBloc({required this.repository, required this.profileRepository})
    : super(const SearchInitial()) {
    on<LoadSearchData>(_onLoadSearchData);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<BrandFilterChanged>(_onBrandFilterChanged);
    on<ApplyFilterCriteria>(_onApplyFilterCriteria);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<List<Car>> _updateCarsWithFavorites(List<Car> cars) async {
    final favoriteIds = await profileRepository.getFavoriteCarIds();
    return cars.map((car) {
      return car.copyWith(isFavorite: favoriteIds.contains(car.id.toString()));
    }).toList();
  }
  // ... (rest of the file is fine until _toggleCarFavorite)

  Future<void> _onLoadSearchData(
    LoadSearchData event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchLoading());
    try {
      final recommended = await repository.getRecommendedCars();
      final popular = await repository.getPopularCars();
      final allCars = await repository.getCarsByBrand(null);

      final recommendedWithFavs = await _updateCarsWithFavorites(recommended);
      final popularWithFavs = await _updateCarsWithFavorites(popular);
      final allCarsWithFavs = await _updateCarsWithFavorites(allCars);

      emit(
        SearchLoaded(
          recommendedCars: recommendedWithFavs,
          popularCars: popularWithFavs,
          filteredCars: allCarsWithFavs,
          selectedBrand: null,
          searchQuery: '',
          activeFilterCriteria: null,
        ),
      );
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      try {
        final cars = await repository.searchCars(event.query);
        final carsWithFavs = await _updateCarsWithFavorites(cars);

        emit(
          currentState.copyWith(
            filteredCars: carsWithFavs,
            searchQuery: event.query,
            clearFilter: true,
          ),
        );
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    }
  }

  Future<void> _onBrandFilterChanged(
    BrandFilterChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      try {
        final cars = await repository.getCarsByBrand(event.brand);
        final carsWithFavs = await _updateCarsWithFavorites(cars);

        emit(
          SearchLoaded(
            recommendedCars: currentState.recommendedCars,
            popularCars: currentState.popularCars,
            filteredCars: carsWithFavs,
            selectedBrand: event.brand,
            searchQuery: '',
            activeFilterCriteria: null,
          ),
        );
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    }
  }

  Future<void> _onApplyFilterCriteria(
    ApplyFilterCriteria event,
    Emitter<SearchState> emit,
  ) async {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      try {
        // If no criteria or clearing filters, show all cars
        if (event.criteria == null || !event.criteria!.hasActiveFilters) {
          final allCars = await repository.getCarsByBrand(null);
          final allCarsWithFavs = await _updateCarsWithFavorites(allCars);
          emit(
            currentState.copyWith(
              filteredCars: allCarsWithFavs,
              clearFilter: true,
            ),
          );
          return;
        }

        // Get all cars first
        final allCars = await repository.getCarsByBrand(null);
        final allCarsWithFavs = await _updateCarsWithFavorites(allCars);

        // Apply filters
        final filteredCars = _applyFilters(allCarsWithFavs, event.criteria!);

        emit(
          currentState.copyWith(
            filteredCars: filteredCars,
            activeFilterCriteria: event.criteria,
          ),
        );
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<SearchState> emit,
  ) async {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      try {
        final isFav = await profileRepository.isFavorite(event.carId);
        if (isFav) {
          await profileRepository.removeFavorite(event.carId);
        } else {
          await profileRepository.addFavorite(event.carId);
        }

        // Update local state
        final updatedRecommended = _toggleCarFavorite(
          currentState.recommendedCars,
          event.carId,
        );
        final updatedPopular = _toggleCarFavorite(
          currentState.popularCars,
          event.carId,
        );
        final updatedFiltered = _toggleCarFavorite(
          currentState.filteredCars,
          event.carId,
        );

        emit(
          currentState.copyWith(
            recommendedCars: updatedRecommended,
            popularCars: updatedPopular,
            filteredCars: updatedFiltered,
          ),
        );
      } catch (e) {
        // Handle error (maybe show snackbar via listener)
      }
    }
  }

  List<Car> _toggleCarFavorite(List<Car> cars, String carId) {
    return cars.map((car) {
      if (car.id.toString() == carId) {
        return car.copyWith(isFavorite: !car.isFavorite);
      }
      return car;
    }).toList();
  }

  List<Car> _applyFilters(List<Car> cars, FilterCriteria criteria) {
    return cars.where((car) {
      // Filter by car type
      if (criteria.carType == CarType.luxuryCars) {
        final luxuryBrands = ['Ferrari', 'Lamborghini'];
        if (!luxuryBrands.contains(car.brand)) {
          return false;
        }
      } else if (criteria.carType == CarType.regularCars) {
        final luxuryBrands = ['Ferrari', 'Lamborghini'];
        if (luxuryBrands.contains(car.brand)) {
          return false;
        }
      }

      // Filter by price range
      if (car.price < criteria.minPrice || car.price > criteria.maxPrice) {
        return false;
      }

      // Filter by seating capacity
      if (criteria.seatingCapacity != null &&
          car.seats != criteria.seatingCapacity) {
        return false;
      }

      return true;
    }).toList();
  }
}
