import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class EditorialImageCarousel extends StatefulWidget {
  const EditorialImageCarousel({
    super.key,
    required this.imageUrls,
    required this.fallbackPalette,
    required this.fallbackIcon,
    required this.fallbackIconSize,
    required this.fallbackAlignment,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.autoPlayInterval = const Duration(seconds: 4),
    this.showIndicators = false,
    this.indicatorAlignment = const Alignment(0.88, 0.9),
    this.overlayBuilder,
  });

  final List<String> imageUrls;
  final List<Color> fallbackPalette;
  final IconData fallbackIcon;
  final double fallbackIconSize;
  final Alignment fallbackAlignment;
  final BorderRadius borderRadius;
  final Duration autoPlayInterval;
  final bool showIndicators;
  final Alignment indicatorAlignment;
  final WidgetBuilder? overlayBuilder;

  @override
  State<EditorialImageCarousel> createState() => _EditorialImageCarouselState();
}

class _EditorialImageCarouselState extends State<EditorialImageCarousel> {
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _configureAutoPlay();
  }

  @override
  void didUpdateWidget(covariant EditorialImageCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.imageUrls != widget.imageUrls) {
      _currentIndex = 0;
      _configureAutoPlay();
    }
  }

  void _configureAutoPlay() {
    _timer?.cancel();

    if (widget.imageUrls.length <= 1) {
      return;
    }

    _timer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (!mounted) return;
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.imageUrls.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasImages = widget.imageUrls.isNotEmpty;
    final currentImageUrl = hasImages ? widget.imageUrls[_currentIndex] : null;

    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 700),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: currentImageUrl == null
                ? _FallbackImagePanel(
                    key: const ValueKey('fallback'),
                    palette: widget.fallbackPalette,
                    icon: widget.fallbackIcon,
                    iconSize: widget.fallbackIconSize,
                    alignment: widget.fallbackAlignment,
                  )
                : _NetworkImagePanel(
                    key: ValueKey(currentImageUrl),
                    imageUrl: currentImageUrl,
                    fallbackPalette: widget.fallbackPalette,
                    fallbackIcon: widget.fallbackIcon,
                    fallbackIconSize: widget.fallbackIconSize,
                    fallbackAlignment: widget.fallbackAlignment,
                  ),
          ),
          if (widget.overlayBuilder != null) widget.overlayBuilder!(context),
          if (widget.showIndicators && widget.imageUrls.length > 1)
            Align(
              alignment: widget.indicatorAlignment,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(widget.imageUrls.length, (index) {
                    final isActive = index == _currentIndex;
                    return Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 0 : 6),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 240),
                        width: isActive ? 28 : 10,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isActive
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.32),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _NetworkImagePanel extends StatelessWidget {
  const _NetworkImagePanel({
    super.key,
    required this.imageUrl,
    required this.fallbackPalette,
    required this.fallbackIcon,
    required this.fallbackIconSize,
    required this.fallbackAlignment,
  });

  final String imageUrl;
  final List<Color> fallbackPalette;
  final IconData fallbackIcon;
  final double fallbackIconSize;
  final Alignment fallbackAlignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _FallbackImagePanel(
          palette: fallbackPalette,
          icon: fallbackIcon,
          iconSize: fallbackIconSize,
          alignment: fallbackAlignment,
        ),
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) {
              return child;
            }
            return _FallbackImagePanel(
              palette: fallbackPalette,
              icon: fallbackIcon,
              iconSize: fallbackIconSize,
              alignment: fallbackAlignment,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return _FallbackImagePanel(
              palette: fallbackPalette,
              icon: fallbackIcon,
              iconSize: fallbackIconSize,
              alignment: fallbackAlignment,
            );
          },
        ),
      ],
    );
  }
}

class _FallbackImagePanel extends StatelessWidget {
  const _FallbackImagePanel({
    super.key,
    required this.palette,
    required this.icon,
    required this.iconSize,
    required this.alignment,
  });

  final List<Color> palette;
  final IconData icon;
  final double iconSize;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return AmbientPhotoPanel(
      palette: palette,
      icon: icon,
      iconSize: iconSize,
      alignment: alignment,
    );
  }
}
