import '../repositories/payment_repository.dart';

/// Use case to process payment
class ProcessPayment {
  final PaymentRepository repository;

  ProcessPayment(this.repository);

  Future<bool> call({
    required String paymentMethodId,
    required double amount,
  }) async {
    return repository.processPayment(
      paymentMethodId: paymentMethodId,
      amount: amount,
    );
  }
}
