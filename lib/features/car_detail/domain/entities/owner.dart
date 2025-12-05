/// Owner entity representing the car owner
class Owner {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isVerified;

  const Owner({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isVerified = false,
  });
}
