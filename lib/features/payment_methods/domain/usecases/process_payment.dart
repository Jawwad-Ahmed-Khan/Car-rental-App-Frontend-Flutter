import '../repositories/payment_repository.dart';

/// Use case to process payment
class ProcessPayment {
  final PaymentRepository repository;

  ProcessPayment(this.repository);

  Future<bool> call({
    required int bookingId,
    required String paymentMethod,
  }) async {
    return repository.processPayment(
      bookingId: bookingId,
      paymentMethod: paymentMethod,
    );
  }
}
