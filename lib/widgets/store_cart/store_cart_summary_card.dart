import 'package:flutter/material.dart';

class StoreCartSummaryCard extends StatelessWidget {
  const StoreCartSummaryCard({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
    required this.onBeginCheckoutTap,
  });

  final String subtotal;
  final String shipping;
  final String tax;
  final String total;
  final VoidCallback onBeginCheckoutTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFADB3B4).withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ORDER SUMMARY',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              letterSpacing: 2.0,
              color: const Color(0xFF815534),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 26),
          _SummaryRow(label: 'Subtotal', value: subtotal),
          const SizedBox(height: 18),
          _SummaryRow(
            label: 'Shipping',
            value: shipping,
            valueColor: const Color(0xFF7D5731),
          ),
          const SizedBox(height: 18),
          _SummaryRow(label: 'Tax', value: tax, hasDivider: true),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Total',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF17191A),
                  ),
                ),
              ),
              Text(
                total,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF17191A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onBeginCheckoutTap,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF815534),
                foregroundColor: const Color(0xFFFFF7F4),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                'BEGIN CHECKOUT RITUAL',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 11,
                  letterSpacing: 1.8,
                  color: const Color(0xFFFFF7F4),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Prices include all applicable duties and international shipping fees.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 11,
              letterSpacing: 0.4,
              color: const Color(0xFF5A6061),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor = const Color(0xFF17191A),
    this.hasDivider = false,
  });

  final String label;
  final String value;
  final Color valueColor;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              letterSpacing: 0,
              color: const Color(0xFF5A6061),
            ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );

    if (!hasDivider) return row;

    return Column(
      children: [
        row,
        const SizedBox(height: 18),
        const Divider(height: 1, color: Color(0x1AADB3B4)),
      ],
    );
  }
}
