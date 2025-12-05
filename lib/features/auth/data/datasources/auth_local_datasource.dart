import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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
  final SharedPreferences sharedPreferences;

  static const String cachedUserKey = 'cachedUser';
  static const String cachedTokenKey = 'cachedToken';

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel?> getCachedUser() async {
    final jsonString = sharedPreferences.getString(cachedUserKey);
    if (jsonString != null) {
      return UserModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferences.setString(cachedUserKey, jsonEncode(user.toJson()));
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(cachedUserKey);
    await sharedPreferences.remove(cachedTokenKey);
  }

  @override
  Future<String?> getToken() async {
    final token = sharedPreferences.getString(cachedTokenKey);
    if (token != null) return token;

    // Fallback: Try to get token from cached user
    final userJson = sharedPreferences.getString(cachedUserKey);
    if (userJson != null) {
      try {
        final Map<String, dynamic> json = jsonDecode(userJson);
        final userToken = json['token'] ?? json['access_token'];
        if (userToken != null && userToken is String && userToken.isNotEmpty) {
          // Cache it for next time
          await cacheToken(userToken);
          return userToken;
        }
      } catch (e) {
        // Ignore parsing errors
      }
    }
    return null;
  }

  @override
  Future<void> cacheToken(String token) async {
    await sharedPreferences.setString(cachedTokenKey, token);
  }
}
