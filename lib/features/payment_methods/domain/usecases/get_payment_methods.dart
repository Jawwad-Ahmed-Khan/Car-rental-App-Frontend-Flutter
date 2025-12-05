import '../entities/payment_method.dart';
import '../repositories/payment_repository.dart';

/// Use case to get available payment methods
class GetPaymentMethods {
  final PaymentRepository repository;

  GetPaymentMethods(this.repository);

  Future<List<PaymentMethod>> call() async {
    return repository.getPaymentMethods();
  }
}

/// Use case to get saved card
class GetSavedCard {
  final PaymentRepository repository;

  GetSavedCard(this.repository);

  Future<SavedCard?> call() async {
    return repository.getSavedCard();
  }
}
