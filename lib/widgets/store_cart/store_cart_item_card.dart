import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class StoreCartItemCard extends StatelessWidget {
  const StoreCartItemCard({
    super.key,
    required this.data,
    this.addDivider = false,
  });

  final StoreCartItemData data;
  final bool addDivider;

  @override
  Widget build(BuildContext context) {
    final content = LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 640;

        final image = ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: AspectRatio(
            aspectRatio: 1,
            child: AmbientPhotoPanel(
              palette: data.palette,
              icon: data.icon,
              iconSize: 92,
              alignment: data.imageAlignment,
            ),
          ),
        );

        final details = Expanded(
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
                          data.category.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontSize: 9,
                                letterSpacing: 1.8,
                                color: const Color(0xFF815534),
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          data.title,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF17191A),
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    data.price,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF17191A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                data.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  height: 1.6,
                  letterSpacing: 0,
                  color: const Color(0xFF5A6061),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F4F4),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.remove, size: 16),
                        const SizedBox(width: 20),
                        Text(
                          data.quantityLabel,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                letterSpacing: 0,
                                color: const Color(0xFF17191A),
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(width: 20),
                        const Icon(Icons.add, size: 16),
                      ],
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF5A6061),
                      padding: EdgeInsets.zero,
                    ),
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: Text(
                      'REMOVE',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.w800,
                      ),
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
            children: [
              SizedBox(width: 220, child: image),
              const SizedBox(width: 24),
              details,
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image,
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.category.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 9,
                          letterSpacing: 1.8,
                          color: const Color(0xFF815534),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF17191A),
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  data.price,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF17191A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              data.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                height: 1.6,
                letterSpacing: 0,
                color: const Color(0xFF5A6061),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F4F4),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.remove, size: 16),
                      const SizedBox(width: 20),
                      Text(
                        data.quantityLabel,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          letterSpacing: 0,
                          color: const Color(0xFF17191A),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.add, size: 16),
                    ],
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF5A6061),
                    padding: EdgeInsets.zero,
                  ),
                  icon: const Icon(Icons.delete_outline, size: 18),
                  label: Text(
                    'REMOVE',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      letterSpacing: 1.8,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (!addDivider) return content;

    return Column(
      children: [
        const Divider(height: 1, color: Color(0x1AADB3B4)),
        const SizedBox(height: 36),
        content,
      ],
    );
  }
}

class StoreCartItemData {
  const StoreCartItemData({
    required this.category,
    required this.title,
    required this.price,
    required this.description,
    required this.quantityLabel,
    required this.icon,
    required this.palette,
    this.imageAlignment = const Alignment(0.58, -0.08),
  });

  final String category;
  final String title;
  final String price;
  final String description;
  final String quantityLabel;
  final IconData icon;
  final List<Color> palette;
  final Alignment imageAlignment;
}
