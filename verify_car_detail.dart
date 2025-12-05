import 'package:http/http.dart' as http;
import 'lib/configs/app_config.dart';
import 'lib/features/car_detail/data/datasources/car_detail_remote_data_source.dart';

void main() async {
  final client = http.Client();
  final config = AppConfig.dev;

  print('--------------------------------------------------');
  print('Car Detail API Verification Script');
  print('Target Base URL: ${config.apiBaseUrl}');
  print('--------------------------------------------------');

  final dataSource = CarDetailRemoteDataSourceImpl(
    client: client,
    appConfig: config,
  );
  final carId = '11'; // Using the ID from previous test

  print('Attempting to fetch details for car ID: $carId...');
  try {
    final carDetail = await dataSource.getCarDetails(carId);
    print('SUCCESS: Fetched details for ${carDetail.brand} ${carDetail.model}');
    print('  ID: ${carDetail.id}');
    print('  Price: ${carDetail.price}');
    print('  Owner: ${carDetail.owner.name}');
    print('  Images: ${carDetail.imageUrls.length}');
    for (var img in carDetail.imageUrls) {
      print('    - $img');
    }
  } catch (e) {
    print('ERROR: Failed to fetch car details.');
    print('Details: $e');
  } finally {
    client.close();
    print('--------------------------------------------------');
  }
}
