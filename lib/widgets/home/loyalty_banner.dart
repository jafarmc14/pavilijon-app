import 'package:flutter/material.dart';

class HomeLoyaltyBanner extends StatelessWidget {
  const HomeLoyaltyBanner({super.key, required this.onBecomeMemberTap});

  final VoidCallback onBecomeMemberTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Join our Ritual',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: const Color(0xFF17191A),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Earn celestial points for every cup and unlock exclusive early access to seasonal micro-lots.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF5A6061),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 22),
          FilledButton(
            onPressed: onBecomeMemberTap,
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF111315),
              foregroundColor: const Color(0xFFF9F9F9),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              shape: const StadiumBorder(),
            ),
            child: Text(
              'BECOME A MEMBER',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFFF9F9F9),
                fontSize: 11,
                letterSpacing: 2.2,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
