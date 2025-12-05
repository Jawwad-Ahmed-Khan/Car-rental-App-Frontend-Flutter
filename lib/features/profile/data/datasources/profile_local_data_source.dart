import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth/domain/entities/user.dart';

/// Local data source handling SharedPreferences operations for user data and favorites
class ProfileLocalDataSource {
  static const String _userKey = 'logged_in_user';
  static const String _favoritesKey = 'favorite_cars';
  static const String _isLoggedInKey = 'is_logged_in';

  /// Get the current logged-in user
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson == null) return null;

    final Map<String, dynamic> userData = json.decode(userJson);
    return User(
      id: userData['id'] ?? '',
      email: userData['email'] ?? '',
      name: userData['name'] ?? '',
      phoneNumber: userData['phoneNumber'],
      photoUrl: userData['photoUrl'],
    );
  }

  /// Save user to SharedPreferences
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = {
      'id': user.id,
      'email': user.email,
      'name': user.name,
      'phoneNumber': user.phoneNumber,
      'photoUrl': user.photoUrl,
    };
    await prefs.setString(_userKey, json.encode(userData));
    await prefs.setBool(_isLoggedInKey, true);
  }

  /// Clear user data (logout)
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// Get list of favorite car IDs
  Future<List<String>> getFavoriteCarIds() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey);
    return favorites ?? [];
  }

  /// Add a car to favorites
  Future<void> addFavorite(String carId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    if (!favorites.contains(carId)) {
      favorites.add(carId);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  /// Remove a car from favorites
  Future<void> removeFavorite(String carId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    favorites.remove(carId);
    await prefs.setStringList(_favoritesKey, favorites);
  }

  /// Check if a car is in favorites
  Future<bool> isFavorite(String carId) async {
    final favorites = await getFavoriteCarIds();
    return favorites.contains(carId);
  }

  /// Clear all favorites
  Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoritesKey);
  }
}
