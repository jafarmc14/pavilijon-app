import 'package:flutter/material.dart';

class GrabAndGoPaymentSuccessStatusCard extends StatelessWidget {
  const GrabAndGoPaymentSuccessStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFFADB3B4).withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: [
              Text(
                'QUEUE IDENTIFICATION',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  letterSpacing: 1.8,
                  color: const Color(0xFF757C7D),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '#042',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  letterSpacing: -2,
                  color: const Color(0xFF2D3435),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F4F4),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Color(0xFF815534),
                size: 26,
              ),
              const SizedBox(height: 8),
              Text(
                'Station A',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF2D3435),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'PICK-UP AREA',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 9,
                  letterSpacing: 1.6,
                  color: const Color(0xFF757C7D),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
