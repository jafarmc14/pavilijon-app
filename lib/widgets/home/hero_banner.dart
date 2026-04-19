import 'package:flutter/material.dart';
import 'package:pavilijon_app/widgets/home/editorial_image_carousel.dart';

class HomeHeroBanner extends StatelessWidget {
  const HomeHeroBanner({super.key, required this.imageUrls});

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.88,
      child: EditorialImageCarousel(
        imageUrls: imageUrls,
        fallbackPalette: const [
          Color(0xFF2A201C),
          Color(0xFF6B5548),
          Color(0xFFD9CEC2),
        ],
        fallbackIcon: Icons.local_cafe_rounded,
        fallbackIconSize: 94,
        fallbackAlignment: const Alignment(0.65, -0.18),
        borderRadius: BorderRadius.circular(28),
        showIndicators: true,
        overlayBuilder: (context) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.08),
                        Colors.black.withValues(alpha: 0.62),
                      ],
                      stops: const [0.2, 0.52, 1.0],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                right: 28,
                bottom: 32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The Morning Ritual',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.86),
                        fontSize: 11,
                        letterSpacing: 2.6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Purity in\nEvery Drop.',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        height: 0.94,
                        letterSpacing: -1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
