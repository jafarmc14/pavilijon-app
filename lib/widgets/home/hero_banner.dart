import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class HomeHeroBanner extends StatelessWidget {
  const HomeHeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.88,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const AmbientPhotoPanel(
              palette: [
                Color(0xFF2A201C),
                Color(0xFF6B5548),
                Color(0xFFD9CEC2),
              ],
              icon: Icons.local_cafe_rounded,
              iconSize: 94,
              alignment: Alignment(0.65, -0.18),
            ),
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
                  const SizedBox(height: 22),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF815534),
                      foregroundColor: const Color(0xFFFFF7F4),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 16,
                      ),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'EXPLORE BEANS',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: const Color(0xFFFFF7F4),
                        fontSize: 10,
                        letterSpacing: 2.4,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 22,
              bottom: 24,
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(width: 6),
                  for (var i = 0; i < 2; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Container(
                        width: 10,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.32),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
