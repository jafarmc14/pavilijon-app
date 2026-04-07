import 'package:flutter/material.dart';

class TrackHeaderSection extends StatelessWidget {
  const TrackHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ORDER STATUS',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: const Color(0xFF815534),
            fontSize: 10,
            letterSpacing: 2.2,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Track Your Ritual',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.8,
            color: const Color(0xFF17191A),
          ),
        ),
      ],
    );
  }
}
