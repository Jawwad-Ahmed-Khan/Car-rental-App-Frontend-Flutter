import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../configs/app_config.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

/// Abstract contract for remote authentication data source
abstract class AuthRemoteDataSource {
  /// Login with email and password
  Future<UserModel> login(String email, String password);

  /// Register new user
  Future<UserModel> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
  );

  /// Logout current user
  Future<void> logout();

  /// Refresh authentication token
  Future<String> refreshToken(String token);
}

/// Implementation of AuthRemoteDataSource
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final AppConfig appConfig;

  AuthRemoteDataSourceImpl({required this.client, required this.appConfig});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('${appConfig.apiBaseUrl}/client/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print('Login Status Code: ${response.statusCode}');
      print('Login Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonBody = jsonDecode(response.body);
        print('Parsed JSON Type: ${jsonBody.runtimeType}');
        print('Parsed JSON Keys: ${jsonBody is Map ? jsonBody.keys.toList() : 'N/A'}');
        
        // Check if user data is nested under 'data' or 'user' key
        Map<String, dynamic> userData;
        if (jsonBody is Map<String, dynamic>) {
          if (jsonBody.containsKey('data')) {
            userData = jsonBody['data'] as Map<String, dynamic>;
            print('User data found under "data" key');
          } else if (jsonBody.containsKey('user')) {
            userData = jsonBody['user'] as Map<String, dynamic>;
            print('User data found under "user" key');
          } else {
            userData = jsonBody;
            print('Using root JSON as user data');
          }
        } else {
          throw ServerException('Unexpected response format');
        }
        
        print('User Data Keys: ${userData.keys.toList()}');
        print('User Data: $userData');
        
        // Merge access_token from root if available
        if (jsonBody.containsKey('access_token') && !userData.containsKey('access_token')) {
          userData['access_token'] = jsonBody['access_token'];
        }
        
        final user = UserModel.fromJson(userData);
        print('Created User: id=${user.id}, email=${user.email}, firstName=${user.firstName}');
        return user;
      } else {
        throw ServerException(
          jsonDecode(response.body)['message'] ?? 'Login failed',
        );
      }
    } catch (e) {
      print('Login Exception: $e');
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
  ) async {
    try {
      final response = await client.post(
        Uri.parse('${appConfig.apiBaseUrl}/client/auth/sign-up'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
          'contact': phoneNumber,
        }),
      );

      print('Register Status Code: ${response.statusCode}');
      print('Register Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        final responseBody = jsonDecode(response.body);
        final message = responseBody['message'];
        final errorMessage = message is List
            ? message.join(', ')
            : message?.toString() ?? 'Registration failed';
        throw ServerException(errorMessage);
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await client.post(
        Uri.parse('${appConfig.apiBaseUrl}/client/auth/logout'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw ServerException('Logout failed');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> refreshToken(String token) async {
    try {
      final response = await client.post(
        Uri.parse('${appConfig.apiBaseUrl}/client/auth/refresh-token'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['token'];
      } else {
        throw ServerException('Token refresh failed');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
