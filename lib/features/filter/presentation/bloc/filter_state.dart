import 'package:equatable/equatable.dart';
import '../../domain/entities/filter_criteria.dart';

/// Base class for all filter states
abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object?> get props => [];
}

/// Initial state before filters are loaded
class FilterInitial extends FilterState {
  const FilterInitial();
}

/// State when filters are loading
class FilterLoading extends FilterState {
  const FilterLoading();
}

/// State when filters are loaded and ready
class FilterLoaded extends FilterState {
  final FilterCriteria criteria;
  final int filteredCarsCount;

  const FilterLoaded({
    required this.criteria,
    required this.filteredCarsCount,
  });

  @override
  List<Object?> get props => [criteria, filteredCarsCount];

  /// Create a copy with updated values
  FilterLoaded copyWith({
    FilterCriteria? criteria,
    int? filteredCarsCount,
  }) {
    return FilterLoaded(
      criteria: criteria ?? this.criteria,
      filteredCarsCount: filteredCarsCount ?? this.filteredCarsCount,
    );
  }
}

/// State when filters are applied and sheet should close
class FilterApplied extends FilterState {
  final FilterCriteria criteria;

  const FilterApplied(this.criteria);

  @override
  List<Object?> get props => [criteria];
}

/// State when there's an error
class FilterError extends FilterState {
  final String message;

  const FilterError(this.message);

  @override
  List<Object?> get props => [message];
}
