import 'dart:ui';

import 'package:flutter/material.dart';

class GrabAndGoVariantBottomAction extends StatelessWidget {
  const GrabAndGoVariantBottomAction({super.key, required this.totalPrice});

  final String totalPrice;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.82),
            border: Border(
              top: BorderSide(
                color: const Color(0xFFADB3B4).withValues(alpha: 0.12),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'TOTAL PRICE',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 9,
                        letterSpacing: 1.8,
                        color: const Color(0xFF5A6061),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      totalPrice,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF121212),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF121212),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  icon: const Icon(Icons.shopping_basket_outlined, size: 20),
                  iconAlignment: IconAlignment.end,
                  label: Text(
                    'ADD TO CART',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 12,
                      letterSpacing: 1.6,
                      color: Colors.white,
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
