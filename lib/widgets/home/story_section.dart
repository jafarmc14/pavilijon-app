import 'package:flutter/material.dart';
import 'package:pavilijon_app/widgets/home/editorial_image_carousel.dart';

class HomeStorySection extends StatelessWidget {
  const HomeStorySection({super.key, required this.imageUrls});

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F4),
        borderRadius: BorderRadius.circular(28),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          final textContent = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OUR STORY',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFF815534),
                  fontSize: 10,
                  letterSpacing: 2.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Born in the backstreets of Omotesando.',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.02,
                  letterSpacing: -0.8,
                  color: const Color(0xFF17191A),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'We believe coffee is more than caffeine. It is a pause. A moment of clarity in a crowded world. Our beans are sourced with precision and roasted in small batches to preserve the silent ceremony of the brew.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF5A6061),
                  height: 1.65,
                ),
              ),
            ],
          );
          final image = AspectRatio(
            aspectRatio: 0.96,
            child: EditorialImageCarousel(
              imageUrls: imageUrls,
              fallbackPalette: const [
                Color(0xFF47403A),
                Color(0xFF74675C),
                Color(0xFFC8B9A9),
              ],
              fallbackIcon: Icons.coffee_maker_outlined,
              fallbackIconSize: 92,
              fallbackAlignment: const Alignment(0.6, -0.08),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              showIndicators: true,
              indicatorAlignment: const Alignment(0.86, 0.9),
            ),
          );

          if (isWide) {
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: textContent,
                  ),
                ),
                Expanded(child: image),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [textContent, const SizedBox(height: 24), image],
          );
        },
      ),
    );
  }
}
