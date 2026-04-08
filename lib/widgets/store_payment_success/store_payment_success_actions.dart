import 'package:flutter/material.dart';

class StorePaymentSuccessActions extends StatelessWidget {
  const StorePaymentSuccessActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Need assistance with your ritual?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            letterSpacing: 0,
            color: const Color(0xFF5A6061),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF17191A),
            padding: EdgeInsets.zero,
          ),
          child: Text(
            'CONTACT CONCIERGE',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.underline,
              decorationColor: const Color(0x3317191A),
            ),
          ),
        ),
      ],
    );
  }
}
