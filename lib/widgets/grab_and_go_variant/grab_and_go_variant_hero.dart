import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';
import 'package:pavilijon_app/widgets/grab_and_go/grab_and_go_menu_card.dart';

class GrabAndGoVariantHero extends StatelessWidget {
  const GrabAndGoVariantHero({super.key, required this.item});

  final GrabAndGoItemData item;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AmbientPhotoPanel(
              palette: item.palette,
              icon: item.icon,
              iconSize: 116,
              alignment: item.imageAlignment,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.08),
                    Colors.black.withValues(alpha: 0.54),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.price,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.86),
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
