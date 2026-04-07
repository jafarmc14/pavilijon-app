import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class GrabAndGoMenuCard extends StatelessWidget {
  const GrabAndGoMenuCard({
    super.key,
    required this.data,
    this.reverseLayout = false,
  });

  final GrabAndGoItemData data;
  final bool reverseLayout;

  @override
  Widget build(BuildContext context) {
    final imageSection = ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(28),
        topRight: const Radius.circular(28),
        bottomLeft: Radius.circular(reverseLayout ? 0 : 28),
        bottomRight: Radius.circular(reverseLayout ? 28 : 0),
      ),
      child: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            AmbientPhotoPanel(
              palette: data.palette,
              icon: data.icon,
              iconSize: 94,
              alignment: data.imageAlignment,
            ),
            if (data.badge != null)
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.82),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    data.badge!.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 9,
                      letterSpacing: 1.8,
                      color: const Color(0xFF815534),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    final contentSection = Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  data.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF17191A),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                data.price,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF815534),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            data.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              height: 1.6,
              letterSpacing: 0,
              color: const Color(0xFF5A6061),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'VESSEL SIZE',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              letterSpacing: 2.0,
              color: const Color(0xFFADB3B4),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: data.sizeOptions
                .map((option) => _SizeChip(data: option))
                .toList(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF815534),
                foregroundColor: const Color(0xFFFFF7F4),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                'QUICK ADD',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: const Color(0xFFFFF7F4),
                  fontSize: 12,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 720;

        if (!isWide) {
          return Container(
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
                AspectRatio(aspectRatio: 4 / 3, child: imageSection),
                contentSection,
              ],
            ),
          );
        }

        final children = reverseLayout
            ? [Expanded(child: contentSection), Expanded(child: imageSection)]
            : [Expanded(child: imageSection), Expanded(child: contentSection)];

        return Container(
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
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        );
      },
    );
  }
}

class _SizeChip extends StatelessWidget {
  const _SizeChip({required this.data});

  final GrabAndGoSizeOption data;

  @override
  Widget build(BuildContext context) {
    final isSelected = data.selected;

    return Container(
      padding: data.compact
          ? const EdgeInsets.symmetric(horizontal: 18, vertical: 12)
          : const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF815534) : Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isSelected ? const Color(0xFF815534) : const Color(0xFFADB3B4),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Text(
        data.label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontSize: 11,
          letterSpacing: 0,
          color: isSelected ? const Color(0xFFFFF7F4) : const Color(0xFF5A6061),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class GrabAndGoItemData {
  const GrabAndGoItemData({
    required this.title,
    required this.price,
    required this.description,
    required this.icon,
    required this.palette,
    required this.sizeOptions,
    required this.surfaceColor,
    this.badge,
    this.imageAlignment = const Alignment(0.6, -0.08),
  });

  final String title;
  final String price;
  final String description;
  final IconData icon;
  final List<Color> palette;
  final List<GrabAndGoSizeOption> sizeOptions;
  final Color surfaceColor;
  final String? badge;
  final Alignment imageAlignment;
}

class GrabAndGoSizeOption {
  const GrabAndGoSizeOption({
    required this.label,
    this.selected = false,
    this.compact = false,
  });

  final String label;
  final bool selected;
  final bool compact;
}
