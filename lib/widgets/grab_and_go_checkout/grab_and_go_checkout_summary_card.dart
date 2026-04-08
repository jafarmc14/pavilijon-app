import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class GrabAndGoCheckoutSummaryCard extends StatelessWidget {
  const GrabAndGoCheckoutSummaryCard({
    super.key,
    required this.onFinalizeRitualTap,
  });

  final VoidCallback onFinalizeRitualTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Text(
            'Order Summary',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
              color: const Color(0xFF2D3435),
            ),
          ),
          const SizedBox(height: 24),
          const _CheckoutItem(
            title: 'Kyoto Pour Over',
            price: 'JPY 850',
            subtitle: 'Medium Roast / No Sugar',
            quantity: 'QTY: 01',
            icon: Icons.local_cafe_outlined,
            palette: [Color(0xFF5C4536), Color(0xFFAA8A73), Color(0xFFE9D7C7)],
          ),
          const SizedBox(height: 18),
          const _CheckoutItem(
            title: 'Ceremonial Mocha',
            price: 'JPY 1,100',
            subtitle: 'Oat Milk / Single Origin',
            quantity: 'QTY: 01',
            icon: Icons.coffee_outlined,
            palette: [Color(0xFF4C362D), Color(0xFF8A6657), Color(0xFFE1D3CC)],
          ),
          const SizedBox(height: 22),
          const Divider(height: 1, color: Color(0x1AADB3B4)),
          const SizedBox(height: 18),
          const _PriceRow(label: 'Subtotal', value: 'JPY 1,950'),
          const SizedBox(height: 12),
          const _PriceRow(label: 'Service Ritual', value: 'JPY 120'),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Text(
                  'TOTAL',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 12,
                    letterSpacing: 2.2,
                    color: const Color(0xFF2D3435),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                'JPY 2,070',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF815534),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onFinalizeRitualTap,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF815534),
                foregroundColor: const Color(0xFFFFF7F4),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                elevation: 8,
                shadowColor: const Color(0x33815534),
              ),
              child: Text(
                'FINALIZE RITUAL',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 11,
                  letterSpacing: 2.0,
                  color: const Color(0xFFFFF7F4),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: Text(
              'ESTIMATED COLLECTION: 12 MINUTES\nFROM TOKYO GINZA CENTRAL',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 9,
                height: 1.8,
                letterSpacing: 1.6,
                color: const Color(0xFF757C7D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckoutItem extends StatelessWidget {
  const _CheckoutItem({
    required this.title,
    required this.price,
    required this.subtitle,
    required this.quantity,
    required this.icon,
    required this.palette,
  });

  final String title;
  final String price;
  final String subtitle;
  final String quantity;
  final IconData icon;
  final List<Color> palette;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 64,
          height: 64,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AmbientPhotoPanel(
              palette: palette,
              icon: icon,
              iconSize: 34,
              alignment: const Alignment(0.58, -0.08),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF2D3435),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    price,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF5A6061),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  letterSpacing: 1.4,
                  color: const Color(0xFF5A6061),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    quantity,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      letterSpacing: 1.4,
                      color: const Color(0xFF757C7D),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'REMOVE',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      letterSpacing: 1.4,
                      color: const Color(0xFF9F403D),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              letterSpacing: 1.6,
              color: const Color(0xFF5A6061),
            ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: const Color(0xFF2D3435),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
