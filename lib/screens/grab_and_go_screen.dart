import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';
import 'package:pavilijon_app/widgets/grab_and_go/grab_and_go_widgets.dart';

class GrabAndGoScreen extends StatelessWidget {
  const GrabAndGoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      GrabAndGoItemData(
        title: 'Ceremony Latte',
        price: '\$6.50',
        description:
            'Double-shot of ethical light roast, paired with silky textured oat milk and a hint of raw honey.',
        icon: Icons.local_cafe_outlined,
        palette: [Color(0xFF6D584B), Color(0xFFB29882), Color(0xFFE7DBD0)],
        sizeOptions: [
          GrabAndGoSizeOption(label: 'S', selected: true),
          GrabAndGoSizeOption(label: 'M'),
          GrabAndGoSizeOption(label: 'L'),
        ],
        surfaceColor: Color(0xFFFFFFFF),
        badge: 'Signature',
        imageAlignment: Alignment(0.55, -0.05),
      ),
      GrabAndGoItemData(
        title: 'Slow Drip',
        price: '\$5.00',
        description:
            'Single origin Ethiopian Yirgacheffe, cold-dripped for 12 hours for a tea-like clarity and citrus notes.',
        icon: Icons.water_drop_outlined,
        palette: [Color(0xFF3A2E28), Color(0xFF7A6457), Color(0xFFD8C6B9)],
        sizeOptions: [GrabAndGoSizeOption(label: 'Standard', compact: true)],
        surfaceColor: Color(0xFFF2F4F4),
        imageAlignment: Alignment(0.62, -0.06),
      ),
      GrabAndGoItemData(
        title: 'Matcha Ritual',
        price: '\$7.25',
        description:
            'Ceremonial grade Uji matcha whisked with water and a float of creamy coconut milk.',
        icon: Icons.spa_outlined,
        palette: [Color(0xFF445639), Color(0xFF7A9662), Color(0xFFDDE7D0)],
        sizeOptions: [
          GrabAndGoSizeOption(label: 'M'),
          GrabAndGoSizeOption(label: 'L', selected: true),
        ],
        surfaceColor: Color(0xFFFFFFFF),
        badge: 'Seasonal',
        imageAlignment: Alignment(0.56, -0.08),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                automaticallyImplyLeading: false,
                toolbarHeight: 72,
                expandedHeight: 72,
                flexibleSpace: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: ColoredBox(
                      color: const Color(0xFFF9F9F9).withValues(alpha: 0.78),
                    ),
                  ),
                ),
                titleSpacing: 0,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const HeaderIconButton(icon: Icons.menu_rounded),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'THE SILENT CEREMONY',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.4,
                                color: const Color(0xFF111315),
                              ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const HeaderIconButton(icon: Icons.search_rounded),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 220),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GrabAndGoHeaderSection(),
                      const SizedBox(height: 28),
                      for (var i = 0; i < items.length; i++) ...[
                        GrabAndGoMenuCard(
                          data: items[i],
                          reverseLayout: i == 1,
                        ),
                        if (i != items.length - 1) const SizedBox(height: 28),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Positioned(
            left: 20,
            right: 20,
            bottom: 100,
            child: GrabAndGoSelectionSummary(
              itemCount: 1,
              totalAmount: '\$6.50',
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavBar(
        activeTab: AppNavTab.grabAndGo,
        currentTab: AppNavTab.grabAndGo,
      ),
    );
  }
}
