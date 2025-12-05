import '../entities/payment_method.dart';

/// Repository interface for payment operations
abstract class PaymentRepository {
  /// Get list of available payment methods
  Future<List<PaymentMethod>> getPaymentMethods();

  /// Get the saved card details
  Future<SavedCard?> getSavedCard();

  /// Process payment with selected method
  /// Returns true if payment was successful
  Future<bool> processPayment({
    required int bookingId,
    required String paymentMethod,
  });
}
