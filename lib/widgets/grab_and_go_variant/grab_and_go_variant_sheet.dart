import 'package:flutter/material.dart';
import 'package:pavilijon_app/widgets/grab_and_go/grab_and_go_menu_card.dart';

class GrabAndGoVariantSheet extends StatelessWidget {
  const GrabAndGoVariantSheet({super.key, required this.item});

  final GrabAndGoItemData item;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    'SIGNATURE BREW',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      letterSpacing: 2.0,
                      color: const Color(0xFF815534),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.8,
                      color: const Color(0xFF121212),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      height: 1.65,
                      color: const Color(0xFF5A6061),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                item.price,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF121212),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        const _SectionLabel(title: 'Size', trailing: 'Required'),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.95,
          children: const [
            _SizeOptionCard(
              title: 'Small',
              subtitle: '12oz',
              icon: Icons.coffee_rounded,
            ),
            _SizeOptionCard(
              title: 'Medium',
              subtitle: '16oz',
              icon: Icons.local_cafe_outlined,
              selected: true,
            ),
            _SizeOptionCard(
              title: 'Big',
              subtitle: '+\$1.00',
              icon: Icons.coffee_maker_outlined,
            ),
          ],
        ),
        const SizedBox(height: 32),
        const _SectionLabel(title: 'Milk'),
        const SizedBox(height: 12),
        const _MilkOptionTile(title: 'Whole', icon: Icons.water_drop_outlined),
        const SizedBox(height: 10),
        const _MilkOptionTile(
          title: 'Oat',
          icon: Icons.grass_outlined,
          priceTag: '+\$0.80',
          selected: true,
        ),
        const SizedBox(height: 10),
        const _MilkOptionTile(
          title: 'Soy',
          icon: Icons.eco_outlined,
          priceTag: '+\$0.80',
        ),
        const SizedBox(height: 32),
        const _SectionLabel(title: 'Sweetness'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            _SweetnessChip(label: 'None'),
            _SweetnessChip(label: 'Low', selected: true),
            _SweetnessChip(label: 'Medium'),
            _SweetnessChip(label: 'High'),
          ],
        ),
        const SizedBox(height: 28),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0x0F815534),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0x1A815534)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: Color(0xFF815534),
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      height: 1.6,
                      color: const Color(0xFF7D5231),
                    ),
                    children: const [
                      TextSpan(
                        text: 'Barista Note: ',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(
                        text:
                            "Oat milk pairs beautifully with low sweetness to keep the espresso profile clean and balanced.",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              letterSpacing: 2.0,
              color: const Color(0xFF5A6061),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        if (trailing != null)
          Text(
            trailing!.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              letterSpacing: 1.6,
              color: const Color(0xFF757C7D),
            ),
          ),
      ],
    );
  }
}

class _SizeOptionCard extends StatelessWidget {
  const _SizeOptionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.selected = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? Colors.white : const Color(0xFFF2F4F4),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected ? const Color(0xFF121212) : Colors.transparent,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: const Color(0xFF121212), size: 28),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF121212),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 10,
                    letterSpacing: 1.2,
                    color: selected
                        ? const Color(0xFF815534)
                        : const Color(0xFF5A6061),
                  ),
                ),
              ],
            ),
          ),
          if (selected)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Color(0xFF121212),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MilkOptionTile extends StatelessWidget {
  const _MilkOptionTile({
    required this.title,
    required this.icon,
    this.priceTag,
    this.selected = false,
  });

  final String title;
  final IconData icon;
  final String? priceTag;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: selected ? Colors.white : const Color(0xFFF2F4F4),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected ? const Color(0xFF121212) : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: selected ? const Color(0xFFE4E9EA) : Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF815534), size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF121212),
                  ),
                ),
                if (priceTag != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    priceTag!,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      letterSpacing: 1.1,
                      color: selected
                          ? const Color(0xFF815534)
                          : const Color(0xFF5A6061),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected
                    ? const Color(0xFF121212)
                    : const Color(0xFFADB3B4),
                width: selected ? 2 : 1,
              ),
            ),
            child: Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF121212)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SweetnessChip extends StatelessWidget {
  const _SweetnessChip({required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF121212) : const Color(0xFFE4E9EA),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontSize: 11,
          letterSpacing: 1.3,
          color: selected ? Colors.white : const Color(0xFF5A6061),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
