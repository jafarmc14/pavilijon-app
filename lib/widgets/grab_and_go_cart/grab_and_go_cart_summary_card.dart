import 'package:flutter/material.dart';

class GrabAndGoCartSummaryCard extends StatelessWidget {
  const GrabAndGoCartSummaryCard({
    super.key,
    required this.subtotal,
    required this.brewingFee,
    required this.total,
    required this.onProceedToCheckoutTap,
  });

  final String subtotal;
  final String brewingFee;
  final String total;
  final VoidCallback onProceedToCheckoutTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F4),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -50,
            bottom: -50,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF815534).withValues(alpha: 0.05),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SummaryRow(label: 'Subtotal', value: subtotal),
              const SizedBox(height: 14),
              _SummaryRow(label: 'Brewing Fee', value: brewingFee),
              const SizedBox(height: 18),
              const Divider(height: 1, color: Color(0x33ADB3B4)),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total Amount',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF2D3435),
                      ),
                    ),
                  ),
                  Text(
                    total,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF2D3435),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onProceedToCheckoutTap,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF815534),
                    foregroundColor: const Color(0xFFFFF7F4),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'PROCEED TO CHECKOUT',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 11,
                      letterSpacing: 1.5,
                      color: const Color(0xFFFFF7F4),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'ESTIMATED READY TIME: 12-15 MINUTES',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 10,
                    letterSpacing: 1.4,
                    color: const Color(0xFF535252),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

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
              fontSize: 11,
              letterSpacing: 1.4,
              color: const Color(0xFF5A6061),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2D3435),
          ),
        ),
      ],
    );
  }
}
