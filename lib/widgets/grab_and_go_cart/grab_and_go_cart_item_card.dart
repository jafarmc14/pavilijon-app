import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class GrabAndGoCartItemData {
  const GrabAndGoCartItemData({
    required this.title,
    required this.price,
    required this.quantityLabel,
    required this.optionChips,
    required this.icon,
    required this.palette,
  });

  final String title;
  final String price;
  final String quantityLabel;
  final List<String> optionChips;
  final IconData icon;
  final List<Color> palette;
}

class GrabAndGoCartItemCard extends StatelessWidget {
  const GrabAndGoCartItemCard({super.key, required this.data});

  final GrabAndGoCartItemData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 560;

          final image = SizedBox(
            width: isWide ? 128 : double.infinity,
            height: 128,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: AmbientPhotoPanel(
                palette: data.palette,
                icon: data.icon,
                iconSize: 54,
                alignment: const Alignment(0.58, -0.1),
              ),
            ),
          );

          final content = Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.3,
                                  color: const Color(0xFF2D3435),
                                ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: data.optionChips
                                .map(
                                  (chip) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE4E9EA),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(
                                      chip.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            fontSize: 9,
                                            letterSpacing: 1.2,
                                            color: const Color(0xFF5A6061),
                                          ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      data.price,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2D3435),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F4F4),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        children: [
                          _StepperButton(icon: Icons.remove_rounded),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              data.quantityLabel,
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF2D3435),
                                  ),
                            ),
                          ),
                          _StepperButton(icon: Icons.add_rounded),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Color(0xFF535252),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [image, const SizedBox(width: 24), content],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [image, const SizedBox(height: 16), content],
          );
        },
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: const Color(0xFF2D3435)),
    );
  }
}
