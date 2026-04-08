import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';
import 'package:pavilijon_app/screens/store_checkout_screen.dart';
import 'package:pavilijon_app/widgets/store_cart/store_cart_widgets.dart';

class StoreCartScreen extends StatelessWidget {
  const StoreCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      StoreCartItemData(
        category: 'Origin: Ethiopia',
        title: 'Floral Ceremony Roast',
        price: '\$32.00',
        description:
            'A light, tea-like profile with notes of jasmine and wild honey. Roasted in small batches to preserve the delicate essential oils.',
        quantityLabel: '01',
        icon: Icons.local_cafe_outlined,
        palette: [Color(0xFF2A201C), Color(0xFF5B4638), Color(0xFFBBAA96)],
      ),
      StoreCartItemData(
        category: 'Equipment: Manual',
        title: 'Precision Manual Press',
        price: '\$185.00',
        description:
            'Engineered for thermal stability and constant pressure. Matte black finish with surgical-grade stainless steel components.',
        quantityLabel: '01',
        icon: Icons.coffee_maker_outlined,
        palette: [Color(0xFF3D4247), Color(0xFF808890), Color(0xFFD7DADD)],
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: CustomScrollView(
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
                  const SizedBox(width: 52),
                  Expanded(
                    child: Text(
                      'THE SILENT CEREMONY',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.4,
                        color: const Color(0xFF111315),
                      ),
                    ),
                  ),
                  const SizedBox(width: 52),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 920;

                  final itemsColumn = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const StoreCartHeaderSection(),
                      const SizedBox(height: 40),
                      for (var i = 0; i < items.length; i++) ...[
                        StoreCartItemCard(data: items[i], addDivider: i != 0),
                        if (i != items.length - 1) const SizedBox(height: 36),
                      ],
                    ],
                  );

                  final summaryColumn = StoreCartSummaryCard(
                    subtotal: '\$217.00',
                    shipping: 'Complimentary',
                    tax: '\$14.20',
                    total: '\$231.20',
                    onBeginCheckoutTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder<void>(
                          transitionDuration: const Duration(milliseconds: 180),
                          reverseTransitionDuration: const Duration(
                            milliseconds: 140,
                          ),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const StoreCheckoutScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                final curved = CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOutCubic,
                                  reverseCurve: Curves.easeInCubic,
                                );
                                return FadeTransition(
                                  opacity: curved,
                                  child: child,
                                );
                              },
                        ),
                      );
                    },
                  );

                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 8, child: itemsColumn),
                        const SizedBox(width: 32),
                        Expanded(flex: 4, child: summaryColumn),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      itemsColumn,
                      const SizedBox(height: 32),
                      summaryColumn,
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ShellBottomBar(
        activeTab: AppNavTab.store,
        currentTab: null,
      ),
    );
  }
}
