import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_local_data_source.dart';

/// Implementation of PaymentRepository
class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentLocalDataSource localDataSource;

  PaymentRepositoryImpl({required this.localDataSource});

  @override
  Future<List<PaymentMethod>> getPaymentMethods() {
    return localDataSource.getPaymentMethods();
  }

  @override
  Future<SavedCard?> getSavedCard() {
    return localDataSource.getSavedCard();
  }

  @override
  Future<bool> processPayment({
    required String paymentMethodId,
    required double amount,
  }) {
    return localDataSource.processPayment(
      paymentMethodId: paymentMethodId,
      amount: amount,
    );
  }
}
