import 'package:flutter/material.dart';
import '../../../../di/injection_container.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../home/domain/entities/car.dart';
import '../../../search/data/datasources/search_local_data_source.dart';

import '../../../search/presentation/widgets/search_car_card.dart';

/// Page displaying all favorite cars from SharedPreferences
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final ProfileRepository _profileRepository;
  final SearchLocalDataSourceImpl _searchDataSource =
      SearchLocalDataSourceImpl();

  List<Car> _favoriteCars = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _profileRepository = sl<ProfileRepository>();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() => _isLoading = true);

    try {
      final favoriteIds = await _profileRepository.getFavoriteCarIds();
      final allCars = await _searchDataSource.getAllCars();

      final favorites = allCars
          .where((car) => favoriteIds.contains(car.id))
          .toList();

      setState(() {
        _favoriteCars = favorites
            .map(
              (carModel) => Car(
                id: carModel.id,
                brand: carModel.brand,
                model: carModel.model,
                year: carModel.year,
                price: carModel.price,
                imageUrl: carModel.imageUrl,
                rating: carModel.rating,
                seats: carModel.seats,
                transmission: carModel.transmission,
                fuelType: carModel.fuelType,
                status: carModel.status,
                isFavorite: true,
              ),
            )
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _removeFromFavorites(String carId) async {
    await _profileRepository.removeFavorite(carId);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.stroke, width: 1),
            ),
            child: const Icon(
              Icons.chevron_left,
              color: AppColors.textPrimary,
              size: 24,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Favorite Cars',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoriteCars.isEmpty
          ? _buildEmptyState()
          : _buildFavoritesList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: AppColors.textSecondary),
          const SizedBox(height: 16),
          const Text(
            'No favorite cars yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.65,
        ),
        itemCount: _favoriteCars.length,
        itemBuilder: (context, index) {
          final car = _favoriteCars[index];
          return SearchCarCard(
            car: car,
            transmission: car.transmission,
            onFavoritePressed: () => _removeFromFavorites(car.id.toString()),
          );
        },
      ),
    );
  }
}
