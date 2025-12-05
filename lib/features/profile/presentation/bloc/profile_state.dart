import 'package:equatable/equatable.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../home/domain/entities/car.dart';

/// States for ProfileBloc
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// Loading state
class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// Profile loaded successfully
class ProfileLoaded extends ProfileState {
  final User? user;
  final List<String> favoriteCarIds;

  const ProfileLoaded({
    this.user,
    this.favoriteCarIds = const [],
  });

  @override
  List<Object?> get props => [user, favoriteCarIds];

  ProfileLoaded copyWith({
    User? user,
    List<String>? favoriteCarIds,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      favoriteCarIds: favoriteCarIds ?? this.favoriteCarIds,
    );
  }
}

/// User logged out
class ProfileLoggedOut extends ProfileState {
  const ProfileLoggedOut();
}

/// Error state
class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Favorites loaded
class FavoritesLoaded extends ProfileState {
  final List<Car> favoriteCars;

  const FavoritesLoaded(this.favoriteCars);

  @override
  List<Object?> get props => [favoriteCars];
}
