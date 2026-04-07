import 'package:flutter/material.dart';

class TrackSearchSection extends StatelessWidget {
  const TrackSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F4),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ENTER QUEUE OR ORDER NUMBER',
                hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  letterSpacing: 1.8,
                  color: const Color(0xFF9C9D9D),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 10,
                letterSpacing: 1.8,
                color: const Color(0xFF17191A),
              ),
            ),
          ),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF815534),
              foregroundColor: const Color(0xFFFFF7F4),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              shape: const StadiumBorder(),
            ),
            child: Text(
              'TRACK',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFFFFF7F4),
                fontSize: 10,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
