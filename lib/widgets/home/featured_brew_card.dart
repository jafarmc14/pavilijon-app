import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class FeaturedBrewCard extends StatelessWidget {
  const FeaturedBrewCard({super.key, required this.data});

  final FeaturedBrewData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 274,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AmbientPhotoPanel(
                    palette: data.palette,
                    icon: data.icon,
                    iconSize: 82,
                    alignment: const Alignment(0.65, -0.08),
                  ),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          color: Colors.white.withValues(alpha: 0.82),
                          child: Text(
                            data.price,
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF1F2324),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            data.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF17191A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13,
              color: const Color(0xFF5A6061),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedBrewData {
  const FeaturedBrewData({
    required this.title,
    required this.description,
    required this.price,
    required this.icon,
    required this.palette,
  });

  final String title;
  final String description;
  final String price;
  final IconData icon;
  final List<Color> palette;
}
