import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../configs/app_config.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../auth/data/datasources/auth_local_datasource.dart';

abstract class PaymentRemoteDataSource {
  Future<bool> processPayment({
    required int bookingId,
    required String paymentMethod,
  });
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final http.Client client;
  final AppConfig appConfig;
  final AuthLocalDataSource authLocalDataSource;

  PaymentRemoteDataSourceImpl({
    required this.client,
    required this.appConfig,
    required this.authLocalDataSource,
  });

  @override
  Future<bool> processPayment({
    required int bookingId,
    required String paymentMethod,
  }) async {
    final url = Uri.parse('${appConfig.apiBaseUrl}/client/bookings/pay');
    final token = await authLocalDataSource.getToken();

    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await client.post(
      url,
      headers: headers,
      body: jsonEncode({
        'bookingId': bookingId,
        'paymentMethod': paymentMethod,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw ServerException('Failed to process payment: ${response.body}');
    }
  }
}
