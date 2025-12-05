import '../../domain/entities/payment_method.dart';

/// Local data source for payment methods (mock data)
class PaymentLocalDataSource {
  /// Get mock payment methods
  Future<List<PaymentMethod>> getPaymentMethods() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return const [
      PaymentMethod(
        id: 'apple_pay',
        name: 'Apple Pay',
        type: PaymentMethodType.applePay,
        isSelected: false,
      ),
      PaymentMethod(
        id: 'google_pay',
        name: 'Google Pay',
        type: PaymentMethodType.googlePay,
        isSelected: false,
      ),
      PaymentMethod(
        id: 'master_card',
        name: 'Master Card',
        type: PaymentMethodType.masterCard,
        isSelected: true, // Default selected
      ),
      PaymentMethod(
        id: 'discover',
        name: 'Discover',
        type: PaymentMethodType.discover,
        isSelected: false,
      ),
      PaymentMethod(
        id: 'amex',
        name: 'AMEX',
        type: PaymentMethodType.amex,
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
