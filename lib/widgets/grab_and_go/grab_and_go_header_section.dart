import 'package:flutter/material.dart';

class GrabAndGoHeaderSection extends StatelessWidget {
  const GrabAndGoHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'To Go Menu',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -1.6,
            color: const Color(0xFF17191A),
          ),
        ),
        const SizedBox(height: 18),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2F4F4),
            borderRadius: BorderRadius.circular(22),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search your ritual...',
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                letterSpacing: 0,
                color: const Color(0xFF9C9D9D),
              ),
              suffixIcon: const Icon(
                Icons.tune_rounded,
                color: Color(0xFFADB3B4),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
