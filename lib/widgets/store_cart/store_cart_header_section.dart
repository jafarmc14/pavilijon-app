import 'package:flutter/material.dart';

class StoreCartHeaderSection extends StatelessWidget {
  const StoreCartHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR SELECTION',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: const Color(0xFF815534),
            fontSize: 10,
            letterSpacing: 2.2,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 720;

            final title = Text(
              'THE CART\nRITUAL',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 56,
                height: 0.95,
                fontWeight: FontWeight.w900,
                letterSpacing: -2.4,
                color: const Color(0xFF17191A),
              ),
            );

            final note = Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.auto_awesome_outlined,
                  size: 18,
                  color: Color(0xFF5A6061),
                ),
                const SizedBox(width: 8),
                Text(
                  'Curated with precision',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0,
                    color: const Color(0xFF5A6061),
                  ),
                ),
              ],
            );

            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: title),
                  const SizedBox(width: 24),
                  note,
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [title, const SizedBox(height: 16), note],
            );
          },
        ),
      ],
    );
  }
}
