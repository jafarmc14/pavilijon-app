import 'dart:ui';

import 'package:flutter/material.dart';

class GrabAndGoSelectionSummary extends StatelessWidget {
  const GrabAndGoSelectionSummary({
    super.key,
    required this.itemCount,
    required this.totalAmount,
    required this.onCheckoutTap,
  });

  final int itemCount;
  final String totalAmount;
  final VoidCallback onCheckoutTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF17191A).withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 28,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$itemCount ITEM SELECTED',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 9,
                        letterSpacing: 2.0,
                        color: const Color(0xFF9C9D9D),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      totalAmount,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: onCheckoutTap,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF815534),
                    foregroundColor: const Color(0xFFFFF7F4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                  label: Text(
                    'CHECKOUT',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      letterSpacing: 1.6,
                      color: const Color(0xFFFFF7F4),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
