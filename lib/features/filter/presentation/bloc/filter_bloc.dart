import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../search/data/datasources/search_local_data_source.dart';
import '../../data/repositories/filter_repository_impl.dart';
import '../../domain/entities/filter_criteria.dart';
import '../../domain/repositories/filter_repository.dart';
import 'filter_event.dart';
import 'filter_state.dart';

/// BLoC for managing filter state
class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final FilterRepository repository;

  FilterBloc({FilterRepository? repository})
      : repository = repository ??
            FilterRepositoryImpl(
              dataSource: SearchLocalDataSourceImpl(),
            ),
        super(const FilterInitial()) {
    on<InitializeFilters>(_onInitializeFilters);
    on<UpdateCarType>(_onUpdateCarType);
    on<UpdatePriceRange>(_onUpdatePriceRange);
    on<UpdateRentalDuration>(_onUpdateRentalDuration);
    on<UpdatePickupDate>(_onUpdatePickupDate);
    on<UpdateLocation>(_onUpdateLocation);
    on<UpdateColor>(_onUpdateColor);
    on<UpdateSeatingCapacity>(_onUpdateSeatingCapacity);
    on<UpdateFuelType>(_onUpdateFuelType);
    on<ClearAllFilters>(_onClearAllFilters);
    on<ApplyFiltersEvent>(_onApplyFilters);
  }

  Future<void> _onInitializeFilters(
    InitializeFilters event,
    Emitter<FilterState> emit,
  ) async {
    emit(const FilterLoading());
    try {
      final count = await repository.getFilteredCarsCount(
        FilterCriteria.defaultCriteria,
      );
      emit(FilterLoaded(
        criteria: FilterCriteria.defaultCriteria,
        filteredCarsCount: count,
      ));
    } catch (e) {
      emit(FilterError(e.toString()));
    }
  }

  Future<void> _updateFilterAndCount(
    Emitter<FilterState> emit,
    FilterCriteria newCriteria,
  ) async {
    if (state is FilterLoaded) {
      try {
        final count = await repository.getFilteredCarsCount(newCriteria);
        emit(FilterLoaded(
          criteria: newCriteria,
          filteredCarsCount: count,
        ));
      } catch (e) {
        emit(FilterError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateCarType(
    UpdateCarType event,
    Emitter<FilterState> emit,
  ) async {
    if (state is FilterLoaded) {
      final currentState = state as FilterLoaded;
      final newCriteria = currentState.criteria.copyWith(carType: event.carType);
      await _updateFilterAndCount(emit, newCriteria);
    }
  }

  Future<void> _onUpdatePriceRange(
    UpdatePriceRange event,
    Emitter<FilterState> emit,
  ) async {
    if (state is FilterLoaded) {
      final currentState = state as FilterLoaded;
      final newCriteria = currentState.criteria.copyWith(
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
      );
      await _updateFilterAndCount(emit, newCriteria);
    }
  }

  Future<void> _onUpdateRentalDuration(
    UpdateRentalDuration event,
    Emitter<FilterState> emit,
  ) async {
    if (state is FilterLoaded) {
      final currentState = state as FilterLoaded;
      final newCriteria = currentState.criteria.copyWith(
        duration: event.duration,
      );
      await _updateFilterAndCount(emit, newCriteria);
    }
  }

  Future<void> _onUpdatePickupDate(
    UpdatePickupDate event,
    Emitter<FilterState> emit,
  ) async {
    if (state is FilterLoaded) {
      final currentState = state as FilterLoaded;
      final newCriteria = currentState.criteria.copyWith(
        pickupDate: event.date,
        clearPickupDate: event.date == null,
      );
      await _updateFilterAndCount(emit, newCriteria);
    }
  }

  Future<void> _onUpdateLocation(
    UpdateLocation event,
    Emitter<FilterState> emit,
  ) async {
    if (state is FilterLoaded) {
      final currentState = state as FilterLoaded;
      final newCriteria = currentState.criteria.copyWith(
        location: event.location,
        clearLocation: event.location == null || event.location!.isEmpty,
      );
      await _updateFilterAndCount(emit, newCriteria);
    }
  }

  Future<void> _onUpdateColor(
    UpdateColor event,
    Emitter<FilterState> emit,
  ) async {
    if (state is FilterLoaded) {
      final currentState = state as FilterLoaded;
      final newCriteria = currentState.criteria.copyWith(
        selectedColor: event.color,
        clearColor: event.color == null,
      );
      await _updateFilterAndCount(emit, newCriteria);
    }
  }

  Future<void> _onUpdateSeatingCapacity(
    UpdateSeatingCapacity event,
    Emitter<FilterState> emit,
  ) async {
    if (state is FilterLoaded) {
      final currentState = state as FilterLoaded;
      final newCriteria = currentState.criteria.copyWith(
        seatingCapacity: event.capacity,
        clearCapacity: event.capacity == null,
      );
      await _updateFilterAndCount(emit, newCriteria);
    }
  }

  Future<void> _onUpdateFuelType(
    UpdateFuelType event,
    Emitter<FilterState> emit,
  ) async {
    if (state is FilterLoaded) {
      final currentState = state as FilterLoaded;
      final newCriteria = currentState.criteria.copyWith(
        fuelType: event.fuelType,
        clearFuelType: event.fuelType == null,
      );
      await _updateFilterAndCount(emit, newCriteria);
    }
  }

  Future<void> _onClearAllFilters(
    ClearAllFilters event,
    Emitter<FilterState> emit,
  ) async {
    try {
      final count = await repository.getFilteredCarsCount(
        FilterCriteria.defaultCriteria,
      );
      emit(FilterLoaded(
        criteria: FilterCriteria.defaultCriteria,
        filteredCarsCount: count,
      ));
    } catch (e) {
      emit(FilterError(e.toString()));
    }
  }

  Future<void> _onApplyFilters(
    ApplyFiltersEvent event,
    Emitter<FilterState> emit,
  ) async {
    if (state is FilterLoaded) {
      final currentState = state as FilterLoaded;
      emit(FilterApplied(currentState.criteria));
    }
  }
}
