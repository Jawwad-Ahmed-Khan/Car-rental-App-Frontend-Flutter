import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../filter/domain/entities/filter_criteria.dart';
import '../../../home/domain/entities/car.dart';
import '../../data/datasources/search_local_data_source.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/repositories/search_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository repository;

  SearchBloc({SearchRepository? repository})
      : repository = repository ??
            SearchRepositoryImpl(
              localDataSource: SearchLocalDataSourceImpl(),
            ),
        super(const SearchInitial()) {
    on<LoadSearchData>(_onLoadSearchData);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<BrandFilterChanged>(_onBrandFilterChanged);
    on<ApplyFilterCriteria>(_onApplyFilterCriteria);
  }

  Future<void> _onLoadSearchData(
    LoadSearchData event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchLoading());
    try {
      final recommended = await repository.getRecommendedCars();
      final popular = await repository.getPopularCars();
      final allCars = await repository.getCarsByBrand(null);

      emit(SearchLoaded(
        recommendedCars: recommended,
        popularCars: popular,
        filteredCars: allCars,
        selectedBrand: null,
        searchQuery: '',
        activeFilterCriteria: null,
      ));
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
        emit(currentState.copyWith(
          filteredCars: cars,
          searchQuery: event.query,
          clearFilter: true,
        ));
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
        emit(SearchLoaded(
          recommendedCars: currentState.recommendedCars,
          popularCars: currentState.popularCars,
          filteredCars: cars,
          selectedBrand: event.brand,
          searchQuery: '',
          activeFilterCriteria: null,
        ));
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
          emit(currentState.copyWith(
            filteredCars: allCars,
            clearFilter: true,
          ));
          return;
        }

        // Get all cars first
        final allCars = await repository.getCarsByBrand(null);
        
        // Apply filters
        final filteredCars = _applyFilters(allCars, event.criteria!);
        
        emit(currentState.copyWith(
          filteredCars: filteredCars,
          activeFilterCriteria: event.criteria,
        ));
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    }
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
      if (criteria.seatingCapacity != null && car.seats != criteria.seatingCapacity) {
        return false;
      }

      return true;
    }).toList();
  }
}

