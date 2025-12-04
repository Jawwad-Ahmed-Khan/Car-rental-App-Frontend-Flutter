import 'package:equatable/equatable.dart';
import '../../domain/entities/filter_criteria.dart';

/// Base class for all filter events
abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object?> get props => [];
}

/// Event to initialize filters
class InitializeFilters extends FilterEvent {
  const InitializeFilters();
}

/// Event to update car type filter
class UpdateCarType extends FilterEvent {
  final CarType carType;

  const UpdateCarType(this.carType);

  @override
  List<Object?> get props => [carType];
}

/// Event to update price range
class UpdatePriceRange extends FilterEvent {
  final double minPrice;
  final double maxPrice;

  const UpdatePriceRange(this.minPrice, this.maxPrice);

  @override
  List<Object?> get props => [minPrice, maxPrice];
}

/// Event to update rental duration
class UpdateRentalDuration extends FilterEvent {
  final RentalDuration duration;

  const UpdateRentalDuration(this.duration);

  @override
  List<Object?> get props => [duration];
}

/// Event to update pickup date
class UpdatePickupDate extends FilterEvent {
  final DateTime? date;

  const UpdatePickupDate(this.date);

  @override
  List<Object?> get props => [date];
}

/// Event to update location
class UpdateLocation extends FilterEvent {
  final String? location;

  const UpdateLocation(this.location);

  @override
  List<Object?> get props => [location];
}

/// Event to update selected color
class UpdateColor extends FilterEvent {
  final CarColor? color;

  const UpdateColor(this.color);

  @override
  List<Object?> get props => [color];
}

/// Event to update seating capacity
class UpdateSeatingCapacity extends FilterEvent {
  final int? capacity;

  const UpdateSeatingCapacity(this.capacity);

  @override
  List<Object?> get props => [capacity];
}

/// Event to update fuel type
class UpdateFuelType extends FilterEvent {
  final FuelType? fuelType;

  const UpdateFuelType(this.fuelType);

  @override
  List<Object?> get props => [fuelType];
}

/// Event to clear all filters
class ClearAllFilters extends FilterEvent {
  const ClearAllFilters();
}

/// Event to apply filters and close the filter sheet
class ApplyFiltersEvent extends FilterEvent {
  const ApplyFiltersEvent();
}
