import '../models/user_model.dart';

/// Abstract contract for local authentication data source
abstract class AuthLocalDataSource {
  /// Get cached user data
  Future<UserModel?> getCachedUser();
  
  /// Cache user data
  Future<void> cacheUser(UserModel user);
  
  /// Clear cached user data
  Future<void> clearCache();
  
  /// Get cached authentication token
  Future<String?> getToken();
  
  /// Cache authentication token
  Future<void> cacheToken(String token);
}

/// Implementation of AuthLocalDataSource using SharedPreferences
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // final SharedPreferences sharedPreferences;

  // AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel?> getCachedUser() async {
    // TODO: Implement cache retrieval
    throw UnimplementedError();
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    // TODO: Implement cache storage
    throw UnimplementedError();
  }

  @override
  Future<void> clearCache() async {
    // TODO: Implement cache clearing
    throw UnimplementedError();
  }

  @override
  Future<String?> getToken() async {
    // TODO: Implement token retrieval
    throw UnimplementedError();
  }

  @override
  Future<void> cacheToken(String token) async {
    // TODO: Implement token storage
    throw UnimplementedError();
  }
}
