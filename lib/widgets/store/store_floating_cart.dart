import 'dart:ui';

import 'package:flutter/material.dart';

class StoreFloatingCart extends StatelessWidget {
  const StoreFloatingCart({
    super.key,
    required this.itemCount,
    required this.totalAmount,
    required this.onReviewOrderTap,
  });

  final int itemCount;
  final String totalAmount;
  final VoidCallback onReviewOrderTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.84),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(
                          Icons.shopping_bag_outlined,
                          color: Color(0xFF815534),
                        ),
                        Positioned(
                          right: -6,
                          top: -4,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: Color(0xFF815534),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '$itemCount',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    fontSize: 8,
                                    letterSpacing: 0,
                                    color: const Color(0xFFFFF7F4),
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'IN YOUR RITUAL',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontSize: 9,
                                letterSpacing: 1.8,
                                color: const Color(0xFF17191A),
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          totalAmount,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF815534),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: onReviewOrderTap,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF815534),
                    foregroundColor: const Color(0xFFFFF7F4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'REVIEW ORDER',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 9,
                      letterSpacing: 1.8,
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
