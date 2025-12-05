import 'package:car_rental/features/main/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../data/datasources/profile_local_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/profile_menu_section.dart';
import 'favorites_page.dart';

/// Main profile page based on Figma design
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        repository: ProfileRepositoryImpl(
          localDataSource: ProfileLocalDataSource(),
        ),
      )..add(const LoadProfile()),
      child: const _ProfilePageContent(),
    );
  }
}

class _ProfilePageContent extends StatelessWidget {
  const _ProfilePageContent();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoggedOut) {
          // Navigate to login page and clear navigation stack
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/login', (route) => false);
        }
      },
      child: Scaffold(
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
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MainPage()),
            ),
          ),
          title: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.stroke, width: 1),
                ),
                child: const Icon(
                  Icons.more_horiz,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
              ),
              onPressed: () {
                // Show menu options
              },
            ),
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            String firstName = 'Benjamin';
            String lastName = 'Jack';
            String email = 'benjaminJack@gmail.com';
            String? avatarUrl;

            if (state is ProfileLoaded && state.user != null) {
              firstName = state.user!.firstName;
              lastName = state.user!.lastName;
              email = state.user!.email;
              avatarUrl = state.user!.photoUrl;
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  ProfileHeader(
                    name: '$firstName $lastName',
                    email: email,
                    avatarUrl: avatarUrl,
                    onEditPressed: () {
                      // Navigate to edit profile
                    },
                  ),

                  const SizedBox(height: 16),

                  // General Section
                  ProfileMenuSection(
                    title: 'General',
                    children: [
                      ProfileMenuItem(
                        icon: Icons.favorite_outline,
                        title: 'Favorite Cars',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const FavoritesPage(),
                            ),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.history,
                        title: 'Previous Rant',
                        onTap: () {
                          // Navigate to previous rentals
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notification',
                        onTap: () {
                          Navigator.of(context).pushNamed('/notifications');
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.connect_without_contact,
                        title: 'Connected to QENT Partnerships',
                        onTap: () {
                          // Navigate to partnerships
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Support Section
                  ProfileMenuSection(
                    title: 'Saport',
                    children: [
                      ProfileMenuItem(
                        icon: Icons.settings_outlined,
                        title: 'Settings',
                        onTap: () {
                          // Navigate to settings
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.translate,
                        title: 'Languages',
                        onTap: () {
                          // Navigate to languages
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.person_add_outlined,
                        title: 'Invite Friends',
                        onTap: () {
                          // Navigate to invite friends
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.description_outlined,
                        title: 'privacy policy',
                        onTap: () {
                          // Navigate to privacy policy
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.help_outline,
                        title: 'Help Support',
                        onTap: () {
                          // Navigate to help support
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.logout,
                        title: 'Log out',
                        onTap: () {
                          _showLogoutDialog(context);
                        },
                      ),
                    ],
                  ),

                  // Bottom padding for navigation bar
                  const SizedBox(height: 100),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<ProfileBloc>().add(const LogoutRequested());
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
