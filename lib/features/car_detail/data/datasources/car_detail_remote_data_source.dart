import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../configs/app_config.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/car_detail_model.dart';

abstract class CarDetailRemoteDataSource {
  Future<CarDetailModel> getCarDetails(String id);
}

class CarDetailRemoteDataSourceImpl implements CarDetailRemoteDataSource {
  final http.Client client;
  final AppConfig appConfig;

  CarDetailRemoteDataSourceImpl({
    required this.client,
    required this.appConfig,
  });

  @override
  Future<CarDetailModel> getCarDetails(String id) async {
    final url = Uri.parse(
      '${appConfig.apiBaseUrl}/public/vehicles/details/$id',
    );
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      return CarDetailModel.fromJson(jsonBody);
    } else {
      throw ServerException(
        'Failed to load car details: ${response.statusCode}',
      );
    }
  }
}
