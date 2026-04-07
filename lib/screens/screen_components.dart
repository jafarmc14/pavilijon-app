import 'dart:ui';

import 'package:flutter/material.dart';

class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({super.key, required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap ?? () {},
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, color: const Color(0xFF111315)),
        ),
      ),
    );
  }
}

class AmbientPhotoPanel extends StatelessWidget {
  const AmbientPhotoPanel({
    super.key,
    required this.palette,
    required this.icon,
    required this.iconSize,
    required this.alignment,
  });

  final List<Color> palette;
  final IconData icon;
  final double iconSize;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: palette,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: -30,
            top: -30,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.12),
              ),
            ),
          ),
          Positioned(
            right: -22,
            bottom: -28,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned.fill(child: CustomPaint(painter: _AmbientLinePainter())),
          Align(
            alignment: alignment,
            child: Icon(
              icon,
              size: iconSize,
              color: Colors.white.withValues(alpha: 0.74),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmbientLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (var i = 0; i < 4; i++) {
      final path = Path()
        ..moveTo(size.width * (0.08 + i * 0.14), 0)
        ..quadraticBezierTo(
          size.width * (0.18 + i * 0.14),
          size.height * 0.42,
          size.width * (0.04 + i * 0.18),
          size.height,
        );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      const _NavItemData(label: 'Home', icon: Icons.home_rounded, active: true),
      const _NavItemData(label: 'Store', icon: Icons.local_cafe_outlined),
      const _NavItemData(label: 'Grab & Go', icon: Icons.shopping_bag_outlined),
      const _NavItemData(label: 'Track', icon: Icons.location_on_outlined),
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(36),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.82),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 32,
                    offset: const Offset(0, -8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: items
                    .map((item) => _BottomNavItem(data: item))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShellBottomBar extends StatelessWidget {
  const ShellBottomBar({super.key, this.onHomeTap});

  final VoidCallback? onHomeTap;

  @override
  Widget build(BuildContext context) {
    final items = [
      const _NavItemData(label: 'Home', icon: Icons.home_rounded),
      const _NavItemData(label: 'Store', icon: Icons.local_cafe_outlined),
      const _NavItemData(label: 'Grab & Go', icon: Icons.shopping_bag_outlined),
      const _NavItemData(label: 'Track', icon: Icons.location_on_outlined),
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 20,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _BottomNavItem(data: items[0], onTap: onHomeTap),
              _BottomNavItem(data: items[1]),
              _BottomNavItem(data: items[2]),
              _BottomNavItem(data: items[3]),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({required this.data, this.onTap});

  final _NavItemData data;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final active = data.active;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: EdgeInsets.symmetric(
            horizontal: active ? 18 : 10,
            vertical: active ? 10 : 8,
          ),
          decoration: BoxDecoration(
            color: active ? const Color(0xFFF2F1EE) : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                data.icon,
                size: 22,
                color: active
                    ? const Color(0xFF17191A)
                    : const Color(0xFF9C9D9D),
              ),
              const SizedBox(height: 4),
              Text(
                data.label.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 9,
                  letterSpacing: 1.8,
                  fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                  color: active
                      ? const Color(0xFF17191A)
                      : const Color(0xFF9C9D9D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({
    required this.label,
    required this.icon,
    this.active = false,
  });

  final String label;
  final IconData icon;
  final bool active;
}
