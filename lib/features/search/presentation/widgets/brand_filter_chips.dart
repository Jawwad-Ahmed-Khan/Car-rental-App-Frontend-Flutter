import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandFilterChips extends StatelessWidget {
  final String? selectedBrand;
  final ValueChanged<String?> onBrandSelected;

  const BrandFilterChips({
    super.key,
    this.selectedBrand,
    required this.onBrandSelected,
  });

  @override
  Widget build(BuildContext context) {
    final brands = [
      {'name': 'ALL', 'icon': null, 'isAll': true},
      {'name': 'Ferrari', 'icon': null, 'isAll': false}, // No logo file available
      {'name': 'Tesla', 'icon': 'assets/icons/tesla_logo.jpg', 'isAll': false},
      {'name': 'BMW', 'icon': 'assets/icons/bmw.svg', 'isAll': false},
      {'name': 'Lamborghini', 'icon': 'assets/icons/lamborghini.svg', 'isAll': false},
    ];

    // If no brand selected, "ALL" is selected
    final currentSelection = selectedBrand ?? 'ALL';

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: brands.length,
        itemBuilder: (context, index) {
          final brand = brands[index];
          final isSelected = currentSelection.toUpperCase() == brand['name'].toString().toUpperCase();
          final isAllChip = brand['isAll'] == true;

          return GestureDetector(
            onTap: () {
              onBrandSelected(isAllChip ? null : brand['name'] as String);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected ? Colors.black : const Color(0xFFD7D7D7),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isAllChip && brand['icon'] != null) ...[
                    _buildBrandIcon(
                      brand['icon'] as String,
                      isSelected,
                    ),
                    const SizedBox(width: 8),
                  ] else if (isAllChip) ...[
                    Icon(
                      Icons.apps,
                      size: 18,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    brand['name'] as String,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBrandIcon(String iconPath, bool isSelected) {
    final isSvg = iconPath.endsWith('.svg');

    if (isSvg) {
      return SizedBox(
        width: 20,
        height: 20,
        child: SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.white : Colors.black,
            BlendMode.srcIn,
          ),
        ),
      );
    } else {
      return ClipOval(
        child: Image.asset(
          iconPath,
          width: 20,
          height: 20,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.directions_car,
              size: 18,
              color: isSelected ? Colors.white : Colors.black,
            );
          },
        ),
      );
    }
  }
}
