import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Entity representing a profile menu item
class ProfileItem extends Equatable {
  final String id;
  final IconData icon;
  final String title;
  final String? route;
  final VoidCallback? onTap;

  const ProfileItem({
    required this.id,
    required this.icon,
    required this.title,
    this.route,
    this.onTap,
  });

  @override
  List<Object?> get props => [id, icon, title, route];
}
