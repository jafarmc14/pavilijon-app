import 'package:flutter/material.dart';

class StoreHeaderSection extends StatelessWidget {
  const StoreHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 720;
        final titleBlock = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PREMIUM SELECTION',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFF815534),
                fontSize: 10,
                letterSpacing: 2.2,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Kohi Store',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -1.6,
                color: const Color(0xFF17191A),
              ),
            ),
          ],
        );

        final searchField = Container(
          constraints: BoxConstraints(maxWidth: isWide ? 320 : double.infinity),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F4F4),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0xFFADB3B4).withValues(alpha: 0.16),
            ),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search rituals...',
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                letterSpacing: 0,
                color: const Color(0xFF9C9D9D),
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: Color(0xFF757C7D),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
            ),
          ),
        );

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: titleBlock),
              const SizedBox(width: 24),
              searchField,
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [titleBlock, const SizedBox(height: 20), searchField],
        );
      },
    );
  }
}
