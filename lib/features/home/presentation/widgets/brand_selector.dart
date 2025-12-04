import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandSelector extends StatefulWidget {
  const BrandSelector({super.key});

  @override
  State<BrandSelector> createState() => _BrandSelectorState();
}

class _BrandSelectorState extends State<BrandSelector> {
  final List<Map<String, String>> brands = [
    {'name': 'Tesla', 'icon': 'assets/icons/tesla_logo.jpg'},
    {'name': 'Lamborghini', 'icon': 'assets/icons/lamborghini.svg'},
    {'name': 'BMW', 'icon': 'assets/icons/bmw.svg'},
    {'name': 'Toyota', 'icon': 'assets/icons/toyota_logo.jpg'},
    // Ferrari logo was missing in the asset list, using text fallback or placeholder if needed.
    // Assuming user might add it later or I should use a placeholder.
    // For now, let's stick to what we found.
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Brands',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final isSelected = index == selectedIndex;
              final iconPath = brands[index]['icon']!;
              final isSvg = iconPath.endsWith('.svg');

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : const Color(0xFFF8F8F8),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: isSvg
                              ? SvgPicture.asset(
                                  iconPath,
                                  colorFilter: isSelected 
                                      ? const ColorFilter.mode(Colors.white, BlendMode.srcIn) 
                                      : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                                  placeholderBuilder: (context) => const Icon(Icons.error),
                                )
                              : Image.asset(
                                  iconPath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                                ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        brands[index]['name']!,
                        style: TextStyle(
                          color: isSelected ? Colors.black : const Color(0xFF7F7F7F),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
