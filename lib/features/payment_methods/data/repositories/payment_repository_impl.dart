import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_local_data_source.dart';
import '../datasources/payment_remote_data_source.dart';

/// Implementation of PaymentRepository
class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentLocalDataSource localDataSource;
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

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
    required int bookingId,
    required String paymentMethod,
  }) {
    return remoteDataSource.processPayment(
      bookingId: bookingId,
      paymentMethod: paymentMethod,
    );
  }
}
