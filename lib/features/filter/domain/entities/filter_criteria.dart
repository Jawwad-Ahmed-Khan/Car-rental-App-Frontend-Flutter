/// Enum representing the type of car for filtering
enum CarType {
  allCars,
  regularCars,
  luxuryCars,
}

/// Enum representing rental duration options
enum RentalDuration {
  hour,
  day,
  weekly,
  monthly,
}

/// Enum representing car color options
enum CarColor {
  white,
  gray,
  blue,
  black,
}

/// Enum representing fuel type options
enum FuelType {
  electric,
  petrol,
  diesel,
  hybrid,
}

/// Entity representing all filter criteria for car search
class FilterCriteria {
  final CarType carType;
  final double minPrice;
  final double maxPrice;
  final RentalDuration duration;
  final DateTime? pickupDate;
  final String? location;
  final CarColor? selectedColor;
  final int? seatingCapacity;
  final FuelType? fuelType;

  const FilterCriteria({
    this.carType = CarType.allCars,
    this.minPrice = 10.0,
    this.maxPrice = 230.0,
    this.duration = RentalDuration.day,
    this.pickupDate,
    this.location,
    this.selectedColor,
    this.seatingCapacity,
    this.fuelType,
  });

  /// Creates a copy with updated fields
  FilterCriteria copyWith({
    CarType? carType,
    double? minPrice,
    double? maxPrice,
    RentalDuration? duration,
    DateTime? pickupDate,
    String? location,
    CarColor? selectedColor,
    int? seatingCapacity,
    FuelType? fuelType,
    bool clearPickupDate = false,
    bool clearLocation = false,
    bool clearColor = false,
    bool clearCapacity = false,
    bool clearFuelType = false,
  }) {
    return FilterCriteria(
      carType: carType ?? this.carType,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      duration: duration ?? this.duration,
      pickupDate: clearPickupDate ? null : (pickupDate ?? this.pickupDate),
      location: clearLocation ? null : (location ?? this.location),
      selectedColor: clearColor ? null : (selectedColor ?? this.selectedColor),
      seatingCapacity: clearCapacity ? null : (seatingCapacity ?? this.seatingCapacity),
      fuelType: clearFuelType ? null : (fuelType ?? this.fuelType),
    );
  }

  /// Returns default filter criteria
  static const FilterCriteria defaultCriteria = FilterCriteria();

  /// Check if any filter is applied (not default)
  bool get hasActiveFilters {
    return carType != CarType.allCars ||
        minPrice != 10.0 ||
        maxPrice != 230.0 ||
        duration != RentalDuration.day ||
        pickupDate != null ||
        location != null ||
        selectedColor != null ||
        seatingCapacity != null ||
        fuelType != null;
  }
}
