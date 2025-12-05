import '../repositories/profile_repository.dart';

/// Use case to get favorite car IDs from SharedPreferences
class GetFavorites {
  final ProfileRepository repository;

  GetFavorites(this.repository);

  Future<List<String>> call() async {
    return await repository.getFavoriteCarIds();
  }
}
