import '../models/user_model.dart';

/// Abstract contract for remote authentication data source
abstract class AuthRemoteDataSource {
  /// Login with email and password
  Future<UserModel> login(String email, String password);
  
  /// Register new user
  Future<UserModel> register(String email, String password, String name);
  
  /// Logout current user
  Future<void> logout();
  
  /// Refresh authentication token
  Future<String> refreshToken(String token);
}

/// Implementation of AuthRemoteDataSource
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // final http.Client client;
  // final String baseUrl;

  // AuthRemoteDataSourceImpl({required this.client, required this.baseUrl});

  @override
  Future<UserModel> login(String email, String password) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<String> refreshToken(String token) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }
}
