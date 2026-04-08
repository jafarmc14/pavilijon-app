import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class StoreCheckoutSummaryCard extends StatelessWidget {
  const StoreCheckoutSummaryCard({super.key, required this.onPayNowTap});

  final VoidCallback onPayNowTap;

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
              fontWeight: FontWeight.w800,
              color: const Color(0xFF17191A),
            ),
          ),
          const SizedBox(height: 22),
          const _CheckoutOrderItem(
            title: 'Tokyo Roast - Single Origin',
            price: 'JPY 1,800',
            subtitle: '250g - Whole Bean',
            icon: Icons.local_cafe_outlined,
            palette: [Color(0xFF2A201C), Color(0xFF5B4638), Color(0xFFBBAA96)],
          ),
          const SizedBox(height: 16),
          const _CheckoutOrderItem(
            title: 'V60 Glass Server',
            price: 'JPY 3,200',
            subtitle: '600ml - Heat Resistant',
            icon: Icons.coffee_maker_outlined,
            palette: [Color(0xFFD7DADD), Color(0xFFABB2BA), Color(0xFFF2F4F4)],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1, color: Color(0x1AADB3B4)),
          const SizedBox(height: 20),
          const _CheckoutPriceRow(label: 'Subtotal', value: 'JPY 5,000'),
          const SizedBox(height: 12),
          const _CheckoutPriceRow(label: 'Delivery Fee', value: 'JPY 550'),
          const SizedBox(height: 12),
          const _CheckoutPriceRow(label: 'Tax (10%)', value: 'JPY 500'),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Color(0x1AADB3B4)),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL AMOUNT',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 9,
                        letterSpacing: 1.8,
                        color: const Color(0xFF815534),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'JPY 6,050',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF17191A),
                          ),
                    ),
                  ],
                ),
              ),
              Text(
                'CURRENCY: JPY',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 9,
                  letterSpacing: 1.8,
                  color: const Color(0xFF9C9D9D),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onPayNowTap,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF121212),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.lock_rounded, size: 18),
              label: Text(
                'PAY NOW',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 11,
                  letterSpacing: 1.8,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'By completing this ritual, you agree to our terms of service and the privacy policy of the silent ceremony.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 10,
              height: 1.6,
              letterSpacing: 0.8,
              color: const Color(0xFF9C9D9D),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckoutOrderItem extends StatelessWidget {
  const _CheckoutOrderItem({
    required this.title,
    required this.price,
    required this.subtitle,
    required this.icon,
    required this.palette,
  });

  final String title;
  final String price;
  final String subtitle;
  final IconData icon;
  final List<Color> palette;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 68,
          height: 68,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AmbientPhotoPanel(
              palette: palette,
              icon: icon,
              iconSize: 36,
              alignment: const Alignment(0.6, -0.1),
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
                        color: const Color(0xFF17191A),
                      ),
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
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 11,
                  letterSpacing: 1.2,
                  color: const Color(0xFF9C9D9D),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CheckoutPriceRow extends StatelessWidget {
  const _CheckoutPriceRow({required this.label, required this.value});

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
              letterSpacing: 1.8,
              color: const Color(0xFF9C9D9D),
            ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            letterSpacing: 0,
            color: const Color(0xFF17191A),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
