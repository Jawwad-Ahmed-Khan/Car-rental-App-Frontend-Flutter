import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/app_config.dart';
import '../core/network/network_info.dart';
import '../features/auth/data/datasources/auth_local_datasource.dart';
import '../features/auth/data/datasources/auth_remote_datasource.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/logout_usecase.dart';
import '../features/auth/domain/usecases/register_usecase.dart';
import '../features/auth/presentation/blocs/auth_bloc.dart';
import '../features/home/data/datasources/home_remote_data_source.dart';
import '../features/home/data/repositories/home_repository_impl.dart';
import '../features/home/domain/repositories/home_repository.dart';
import '../features/home/domain/usecases/get_cars.dart';
import '../features/car_detail/data/datasources/car_detail_remote_data_source.dart';
import '../features/car_detail/data/repositories/car_detail_repository_impl.dart';
import '../features/car_detail/domain/repositories/car_detail_repository.dart';
import '../features/car_detail/domain/usecases/get_car_details.dart';
import '../features/booking/data/datasources/booking_remote_data_source.dart';
import '../features/booking/data/repositories/booking_repository_impl.dart';
import '../features/booking/domain/repositories/booking_repository.dart';
import '../features/booking_details/data/repositories/booking_details_repository_impl.dart';
import '../features/booking_details/domain/repositories/booking_details_repository.dart';
import '../features/booking_details/data/datasources/booking_details_local_data_source.dart';
import '../features/booking/domain/usecases/create_booking.dart';
import '../features/booking_details/domain/usecases/get_initial_booking_details.dart';
import '../features/search/data/datasources/search_remote_data_source.dart';
import '../features/search/data/repositories/search_repository_impl.dart';
import '../features/search/domain/repositories/search_repository.dart';
import '../features/search/presentation/bloc/search_bloc.dart';
import '../features/profile/data/datasources/profile_local_data_source.dart';
import '../features/profile/data/repositories/profile_repository_impl.dart';
import '../features/profile/domain/repositories/profile_repository.dart';

/// Dependency injection container using GetIt
final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> init() async {
  // Features - Auth
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl(), appConfig: sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Home
  // Use cases
  sl.registerLazySingleton(() => GetCars(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(client: sl(), appConfig: sl()),
  );

  // Features - Car Detail
  // Use cases
  sl.registerLazySingleton(() => GetCarDetails(sl()));

  // Repository
  sl.registerLazySingleton<CarDetailRepository>(
    () => CarDetailRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CarDetailRemoteDataSource>(
    () => CarDetailRemoteDataSourceImpl(client: sl(), appConfig: sl()),
  );

  // Features - Booking
  // Use cases
  // Use cases
  sl.registerLazySingleton(() => CreateBooking(sl()));
  sl.registerLazySingleton(() => GetInitialBookingDetails(sl(), sl()));

  // Repository
  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(
      client: sl(),
      appConfig: sl(),
      authLocalDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<BookingDetailsRepository>(
    () => BookingDetailsRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<BookingDetailsLocalDataSource>(
    () => BookingDetailsLocalDataSource(),
  );

  // Features - Search
  // Bloc
  sl.registerFactory(
    () => SearchBloc(repository: sl(), profileRepository: sl()),
  );

  // Repository
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(client: sl(), appConfig: sl()),
  );

  // Features - Profile
  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSource(),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<AppConfig>(() => AppConfig.dev);

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
