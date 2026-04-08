import 'package:flutter/material.dart';

class GrabAndGoPaymentSuccessVisual extends StatelessWidget {
  const GrabAndGoPaymentSuccessVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 22,
            right: 18,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFDCC5).withValues(alpha: 0.4),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF815534).withValues(alpha: 0.08),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 0,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE5E2E1).withValues(alpha: 0.45),
              ),
            ),
          ),
          Container(
            width: 176,
            height: 176,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF2F4F4),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF815534).withValues(alpha: 0.08),
                  blurRadius: 50,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.coffee_maker_outlined,
              size: 72,
              color: Color(0xFF815534),
            ),
          ),
        ],
      ),
    );
  }
}
