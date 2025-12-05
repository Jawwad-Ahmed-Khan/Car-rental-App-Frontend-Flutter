import '../../domain/entities/payment_method.dart';

/// Local data source for payment methods (mock data)
class PaymentLocalDataSource {
  /// Get mock payment methods
  Future<List<PaymentMethod>> getPaymentMethods() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return const [
      PaymentMethod(
        id: 'cash',
        name: 'Cash',
        type: PaymentMethodType.cash,
        isSelected: true, // Default selected
      ),
      PaymentMethod(
        id: 'credit_card',
        name: 'Credit Card',
        type: PaymentMethodType.card,
        isSelected: false,
      ),
    ];
  }

  /// Get mock saved card
  Future<SavedCard?> getSavedCard() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));

    return const SavedCard(
      id: 'card_1',
      cardNumber: '9655',
      cardHolderName: 'Banjamin Jack',
      expiryDate: '10-5-2030',
      cardType: 'Visa',
    );
  }

  /// Mock payment processing
  Future<bool> processPayment({
    required String paymentMethodId,
    required double amount,
  }) async {
    // Simulate payment processing delay
    await Future.delayed(const Duration(seconds: 2));

    // Always return success for mock
    return true;
  }
}
