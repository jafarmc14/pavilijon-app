import 'package:flutter/material.dart';

class GrabAndGoCartHeaderSection extends StatelessWidget {
  const GrabAndGoCartHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR RITUAL SELECTION',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: 10,
            letterSpacing: 1.8,
            color: const Color(0xFF535252),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'To-Go Cart',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
            color: const Color(0xFF2D3435),
          ),
        ),
      ],
    );
  }
}
