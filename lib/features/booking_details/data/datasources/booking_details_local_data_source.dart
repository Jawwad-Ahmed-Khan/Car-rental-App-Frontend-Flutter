import '../../domain/entities/booking_details.dart';

/// Local data source for booking details
class BookingDetailsLocalDataSource {
  /// Get initial booking details with default values
  Future<BookingDetails> getInitialBookingDetails(
      String carId, double price) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final now = DateTime.now();
    final pickupDate = DateTime(now.year, now.month, now.day + 1);
    final returnDate = DateTime(now.year, now.month, now.day + 3);
    final duration = returnDate.difference(pickupDate).inDays;
    
    return BookingDetails(
      carId: carId,
      pricePerDay: price,
      totalPrice: price * duration,
      pickupDate: pickupDate,
      returnDate: returnDate,
      location: 'Shore Dr, Chicago 0062 Usa',
      gender: Gender.male,
      rentalType: RentalType.day,
    );
  }

  /// Submit booking (mock implementation)
  Future<bool> submitBooking(BookingDetails booking) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // In a real app, this would send data to server
    // For now, just validate and return success
    if (booking.isValid) {
      return true;
    }
    return false;
  }
}
