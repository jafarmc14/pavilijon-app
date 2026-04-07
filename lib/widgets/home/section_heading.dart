import 'package:flutter/material.dart';

class HomeSectionHeading extends StatelessWidget {
  const HomeSectionHeading({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.actionLabel,
  });

  final String eyebrow;
  final String title;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eyebrow.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFF815534),
                  fontSize: 10,
                  letterSpacing: 2.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.8,
                  color: const Color(0xFF17191A),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF2D3435),
            padding: EdgeInsets.zero,
          ),
          child: Text(
            actionLabel.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              letterSpacing: 1.8,
              decoration: TextDecoration.underline,
              decorationColor: const Color(0xFFADB3B4),
            ),
          ),
        ),
      ],
    );
  }
}
