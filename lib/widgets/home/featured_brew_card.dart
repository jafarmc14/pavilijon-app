import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/data/homepage_content.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class FeaturedBrewCard extends StatelessWidget {
  const FeaturedBrewCard({super.key, required this.data});

  final HomepageSignatureMenuItem data;

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
                  const AmbientPhotoPanel(
                    palette: [Color(0xFF30211A), Color(0xFF6D4C39)],
                    icon: Icons.local_cafe_rounded,
                    iconSize: 82,
                    alignment: Alignment(0.65, -0.08),
                  ),
                  if (data.imageUrl.isNotEmpty)
                    Image.network(
                      data.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox.shrink();
                      },
                    ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.06),
                            Colors.black.withValues(alpha: 0.24),
                          ],
                          stops: const [0.18, 0.55, 1],
                        ),
                      ),
                    ),
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
                            data.formattedPriceGross,
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
            data.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF17191A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.displayDescription,
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
