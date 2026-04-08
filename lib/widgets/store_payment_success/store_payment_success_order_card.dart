import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class StorePaymentSuccessOrderCard extends StatelessWidget {
  const StorePaymentSuccessOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F4),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFADB3B4).withValues(alpha: 0.1),
        ),
      ),
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
                      'ORDER STATUS',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        letterSpacing: 1.8,
                        color: const Color(0xFF5A6061),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '#SR-2024',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF815534),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'ARRIVAL',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        letterSpacing: 1.8,
                        color: const Color(0xFF5A6061),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'APR 08, 2026',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF17191A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          const _SuccessOrderItem(
            title: 'Kurasu House Blend',
            subtitle: 'Dark Roast - 250g',
            price: 'JPY 2,800',
            icon: Icons.local_cafe_outlined,
            palette: [Color(0xFF2A201C), Color(0xFF5B4638), Color(0xFFBBAA96)],
          ),
          const SizedBox(height: 14),
          const _SuccessOrderItem(
            title: 'Hario V60 Copper',
            subtitle: 'Special Edition',
            price: 'JPY 12,400',
            icon: Icons.coffee_maker_outlined,
            palette: [Color(0xFFA56B44), Color(0xFFD5A784), Color(0xFFF2E5DA)],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1, color: Color(0x1AADB3B4)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  'TOTAL AMOUNT',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 10,
                    letterSpacing: 1.8,
                    color: const Color(0xFF5A6061),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                'JPY 15,200',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF17191A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SuccessOrderItem extends StatelessWidget {
  const _SuccessOrderItem({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.icon,
    required this.palette,
  });

  final String title;
  final String subtitle;
  final String price;
  final IconData icon;
  final List<Color> palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            height: 72,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AmbientPhotoPanel(
                palette: palette,
                icon: icon,
                iconSize: 40,
                alignment: const Alignment(0.58, -0.08),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF17191A),
                  ),
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
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            price,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              letterSpacing: 0,
              color: const Color(0xFF17191A),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
