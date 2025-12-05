import 'package:equatable/equatable.dart';

/// Events for ProfileBloc
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load user profile
class LoadProfile extends ProfileEvent {
  const LoadProfile();
}

/// Event to request logout
class LogoutRequested extends ProfileEvent {
  const LogoutRequested();
}

/// Event to load favorite cars
class LoadFavorites extends ProfileEvent {
  const LoadFavorites();
}

/// Event to toggle car favorite status
class ToggleFavorite extends ProfileEvent {
  final String carId;

  const ToggleFavorite(this.carId);

  @override
  List<Object?> get props => [carId];
}
