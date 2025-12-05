import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/profile_repository_impl.dart';
import 'profile_event.dart';
import 'profile_state.dart';

/// BLoC managing profile state and handling logout logic
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositoryImpl repository;

  ProfileBloc({required this.repository}) : super(const ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<LogoutRequested>(_onLogoutRequested);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    final userResult = await repository.getUserProfile();
    final favoriteIds = await repository.getFavoriteCarIds();

    userResult.fold(
      (error) => emit(ProfileError(error.toString())),
      (user) => emit(ProfileLoaded(
        user: user,
        favoriteCarIds: favoriteIds,
      )),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    final result = await repository.logout();

    result.fold(
      (error) => emit(ProfileError(error.toString())),
      (_) => emit(const ProfileLoggedOut()),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      final isFavorite = await repository.isFavorite(event.carId);
      
      if (isFavorite) {
        await repository.removeFavorite(event.carId);
      } else {
        await repository.addFavorite(event.carId);
      }

      final updatedFavorites = await repository.getFavoriteCarIds();
      emit(currentState.copyWith(favoriteCarIds: updatedFavorites));
    }
  }
}
