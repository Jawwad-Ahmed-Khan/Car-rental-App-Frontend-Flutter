import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/filter_criteria.dart';
import '../bloc/filter_bloc.dart';
import '../bloc/filter_event.dart';
import '../bloc/filter_state.dart';
import '../widgets/filter_header.dart';
import '../widgets/car_type_selector.dart';
import '../widgets/price_range_slider.dart';
import '../widgets/rental_time_chips.dart';
import '../widgets/date_picker_field.dart';
import '../widgets/location_input_field.dart';
import '../widgets/color_selector.dart';
import '../widgets/capacity_selector.dart';
import '../widgets/fuel_type_selector.dart';
import '../widgets/filter_action_buttons.dart';

/// Filter page shown as a bottom sheet
class FilterPage extends StatelessWidget {
  final Function(FilterCriteria)? onFiltersApplied;

  const FilterPage({
    super.key,
    this.onFiltersApplied,
  });

  /// Show the filter page as a bottom sheet
  static Future<FilterCriteria?> show(BuildContext context) {
    return showModalBottomSheet<FilterCriteria>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => BlocProvider(
          create: (context) => FilterBloc()..add(const InitializeFilters()),
          child: FilterPageContent(
            scrollController: scrollController,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterBloc()..add(const InitializeFilters()),
      child: const FilterPageContent(),
    );
  }
}

class FilterPageContent extends StatelessWidget {
  final ScrollController? scrollController;

  const FilterPageContent({
    super.key,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterBloc, FilterState>(
      listener: (context, state) {
        if (state is FilterApplied) {
          Navigator.of(context).pop(state.criteria);
        }
      },
      builder: (context, state) {
        if (state is FilterLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FilterError) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is FilterLoaded) {
          return _buildContent(context, state);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildContent(BuildContext context, FilterLoaded state) {
    return Column(
      children: [
        // Drag handle
        Container(
          margin: const EdgeInsets.only(top: 12),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFFD7D7D7),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Header
        FilterHeader(
          onClose: () => Navigator.of(context).pop(),
        ),
        // Divider
        const Divider(color: Color(0xFFD7D7D7), height: 1),
        // Scrollable content
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type of Cars
                CarTypeSelector(
                  selectedType: state.criteria.carType,
                  onTypeSelected: (type) {
                    context.read<FilterBloc>().add(UpdateCarType(type));
                  },
                ),
                const SizedBox(height: 24),
                const Divider(color: Color(0xFFD7D7D7), height: 1),
                const SizedBox(height: 24),
                // Price Range
                PriceRangeSlider(
                  minPrice: state.criteria.minPrice,
                  maxPrice: state.criteria.maxPrice,
                  onChanged: (values) {
                    context.read<FilterBloc>().add(
                          UpdatePriceRange(values.start, values.end),
                        );
                  },
                ),
                const SizedBox(height: 24),
                const Divider(color: Color(0xFFD7D7D7), height: 1),
                const SizedBox(height: 24),
                // Rental Time
                RentalTimeChips(
                  selectedDuration: state.criteria.duration,
                  onDurationSelected: (duration) {
                    context.read<FilterBloc>().add(
                          UpdateRentalDuration(duration),
                        );
                  },
                ),
                const SizedBox(height: 24),
                // Date Picker
                DatePickerField(
                  selectedDate: state.criteria.pickupDate,
                  onDateSelected: (date) {
                    context.read<FilterBloc>().add(UpdatePickupDate(date));
                  },
                ),
                const SizedBox(height: 24),
                // Location
                LocationInputField(
                  location: state.criteria.location,
                  onLocationChanged: (location) {
                    context.read<FilterBloc>().add(UpdateLocation(location));
                  },
                ),
                const SizedBox(height: 24),
                const Divider(color: Color(0xFFD7D7D7), height: 1),
                const SizedBox(height: 24),
                // Colors
                ColorSelector(
                  selectedColor: state.criteria.selectedColor,
                  onColorSelected: (color) {
                    context.read<FilterBloc>().add(UpdateColor(color));
                  },
                ),
                const SizedBox(height: 24),
                // Seating Capacity
                CapacitySelector(
                  selectedCapacity: state.criteria.seatingCapacity,
                  onCapacitySelected: (capacity) {
                    context.read<FilterBloc>().add(
                          UpdateSeatingCapacity(capacity),
                        );
                  },
                ),
                const SizedBox(height: 24),
                // Fuel Type
                FuelTypeSelector(
                  selectedFuelType: state.criteria.fuelType,
                  onFuelTypeSelected: (fuelType) {
                    context.read<FilterBloc>().add(UpdateFuelType(fuelType));
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        // Action buttons
        FilterActionButtons(
          carsCount: state.filteredCarsCount,
          onClearAll: () {
            context.read<FilterBloc>().add(const ClearAllFilters());
          },
          onShowCars: () {
            context.read<FilterBloc>().add(const ApplyFiltersEvent());
          },
        ),
      ],
    );
  }
}
