import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../configs/app_config.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/car_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CarModel>> fetchCars();
  Future<CarModel> fetchCarDetails(int id);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;
  final AppConfig appConfig;

  HomeRemoteDataSourceImpl({required this.client, required this.appConfig});

  @override
  Future<List<CarModel>> fetchCars() async {
    try {
      final response = await client.get(
        Uri.parse('${appConfig.apiBaseUrl}/public/vehicles/list'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = jsonDecode(response.body);
        final List<dynamic> jsonList = jsonBody['data'];
        print("Car Fetched Successfully." + jsonList.toString());
        return jsonList.map((json) => CarModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to fetch cars: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CarModel> fetchCarDetails(int id) async {
    try {
      final response = await client.get(
        Uri.parse('${appConfig.apiBaseUrl}/public/vehicles/details/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return CarModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException(
          'Failed to fetch car details: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
