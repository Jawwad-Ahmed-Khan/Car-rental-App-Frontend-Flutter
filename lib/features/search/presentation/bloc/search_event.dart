import 'package:equatable/equatable.dart';
import '../../../filter/domain/entities/filter_criteria.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load initial data
class LoadSearchData extends SearchEvent {
  const LoadSearchData();
}

/// Event when search query changes
class SearchQueryChanged extends SearchEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

/// Event when brand filter changes
class BrandFilterChanged extends SearchEvent {
  final String? brand;

  const BrandFilterChanged(this.brand);

  @override
  List<Object?> get props => [brand];
}

/// Event to apply filter criteria from filter page
class ApplyFilterCriteria extends SearchEvent {
  final FilterCriteria? criteria;

  const ApplyFilterCriteria(this.criteria);

  @override
  List<Object?> get props => [criteria];
}

/// Event to toggle favorite status
class ToggleFavorite extends SearchEvent {
  final String carId;

  const ToggleFavorite(this.carId);

  @override
  List<Object?> get props => [carId];
}

