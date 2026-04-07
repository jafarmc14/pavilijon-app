import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class StoreProductCard extends StatelessWidget {
  const StoreProductCard({
    super.key,
    required this.data,
    this.addTopSpacing = false,
  });

  final StoreProductData data;
  final bool addTopSpacing;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        color: data.surfaceColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            child: AspectRatio(
              aspectRatio: 4 / 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AmbientPhotoPanel(
                    palette: data.palette,
                    icon: data.icon,
                    iconSize: 96,
                    alignment: data.imageAlignment,
                  ),
                  Positioned(
                    top: 18,
                    right: 18,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        data.price,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF17191A),
                            ),
                      ),
                    ),
                  ),
                  if (data.badge != null)
                    Positioned(
                      top: data.badgeAtBottom ? null : 18,
                      bottom: data.badgeAtBottom ? 18 : null,
                      left: 18,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: data.badgeColor,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          data.badge!.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontSize: 9,
                                letterSpacing: 1.8,
                                color: data.badgeTextColor,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.category.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 9,
                    letterSpacing: 1.8,
                    color: const Color(0xFF815534),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                    color: const Color(0xFF17191A),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  data.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    height: 1.6,
                    color: const Color(0xFF5A6061),
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF815534),
                      foregroundColor: const Color(0xFFFFF7F4),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                    label: Text(
                      'ADD TO RITUAL',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        letterSpacing: 2.0,
                        color: const Color(0xFFFFF7F4),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (!addTopSpacing) return card;
    return Padding(padding: const EdgeInsets.only(top: 64), child: card);
  }
}

class StoreProductData {
  const StoreProductData({
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.icon,
    required this.palette,
    required this.surfaceColor,
    this.badge,
    this.badgeColor = const Color(0xFF815534),
    this.badgeTextColor = const Color(0xFFFFF7F4),
    this.badgeAtBottom = false,
    this.imageAlignment = const Alignment(0.58, -0.08),
  });

  final String category;
  final String title;
  final String description;
  final String price;
  final IconData icon;
  final List<Color> palette;
  final Color surfaceColor;
  final String? badge;
  final Color badgeColor;
  final Color badgeTextColor;
  final bool badgeAtBottom;
  final Alignment imageAlignment;
}
