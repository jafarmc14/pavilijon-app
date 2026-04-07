import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class HomeLocationSection extends StatelessWidget {
  const HomeLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 720;
        final details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'THE WORKSHOP',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFF815534),
                fontSize: 10,
                letterSpacing: 2.2,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Shibuya, Tokyo',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF17191A),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '4-26-14 Jingumae\nShibuya-ku, Tokyo 150-0001\nJapan',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF5A6061),
                height: 1.55,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2FB45A),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Currently Open',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 13,
                    letterSpacing: 0,
                    color: const Color(0xFF17191A),
                  ),
                ),
              ],
            ),
          ],
        );

        const map = ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(28)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AmbientPhotoPanel(
                palette: [
                  Color(0xFFD7D3CE),
                  Color(0xFFB9B3AB),
                  Color(0xFFF1ECE6),
                ],
                icon: Icons.map_outlined,
                iconSize: 84,
                alignment: Alignment(0.55, -0.18),
              ),
            ],
          ),
        );

        final mapWithPin = Stack(
          fit: StackFit.expand,
          children: [
            map,
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.06),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  color: Color(0xFF815534),
                  size: 28,
                ),
              ),
            ),
          ],
        );

        if (isWide) {
          return SizedBox(
            height: 270,
            child: Row(
              children: [
                Expanded(child: details),
                const SizedBox(width: 24),
                Expanded(flex: 2, child: mapWithPin),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            details,
            const SizedBox(height: 20),
            SizedBox(height: 240, child: mapWithPin),
          ],
        );
      },
    );
  }
}
