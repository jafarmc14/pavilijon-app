import 'package:flutter/material.dart';

class HomeTermsEntryCard extends StatelessWidget {
  const HomeTermsEntryCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFADB3B4).withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DOCUMENTS',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: const Color(0xFF815534),
              fontSize: 10,
              letterSpacing: 2.2,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Terms & Conditions (Regulamin)',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -0.6,
              color: const Color(0xFF17191A),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Baca ketentuan penggunaan, aturan komunitas, dan standar layanan kami dalam satu halaman editorial.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF5A6061),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 22),
          OutlinedButton.icon(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF17191A),
              side: BorderSide(
                color: const Color(0xFFADB3B4).withValues(alpha: 0.45),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              shape: const StadiumBorder(),
            ),
            icon: const Icon(Icons.receipt_long_outlined, size: 20),
            label: Text(
              'OPEN TERMS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
