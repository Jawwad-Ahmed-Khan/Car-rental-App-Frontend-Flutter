import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../configs/app_config.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../auth/data/datasources/auth_local_datasource.dart';
import '../models/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<BookingModel> createBooking(BookingModel booking);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final http.Client client;
  final AppConfig appConfig;
  final AuthLocalDataSource authLocalDataSource;

  BookingRemoteDataSourceImpl({
    required this.client,
    required this.appConfig,
    required this.authLocalDataSource,
  });

  @override
  Future<BookingModel> createBooking(BookingModel booking) async {
    final url = Uri.parse('${appConfig.apiBaseUrl}/client/bookings/create');
    final token = await authLocalDataSource.getToken();

    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await client.post(
      url,
      headers: headers,
      body: jsonEncode(booking.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return BookingModel.fromJson(body['booking']);
    } else {
      throw ServerException('Failed to create booking: ${response.body}');
    }
  }
}
