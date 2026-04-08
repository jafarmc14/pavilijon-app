import 'package:flutter/material.dart';

class StorePaymentSuccessHeader extends StatelessWidget {
  const StorePaymentSuccessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.check_circle_rounded,
            color: Color(0xFF815534),
            size: 34,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'The Ritual Awaits',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -1.4,
            color: const Color(0xFF17191A),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your selection has been curated and is being prepared with precision.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF5A6061),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
