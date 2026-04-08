import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/grab_and_go_checkout_screen.dart';
import 'package:pavilijon_app/screens/screen_components.dart';
import 'package:pavilijon_app/widgets/grab_and_go_cart/grab_and_go_cart_widgets.dart';

class GrabAndGoCartScreen extends StatelessWidget {
  const GrabAndGoCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      GrabAndGoCartItemData(
        title: 'Ceremony Latte',
        price: '\$7.50',
        quantityLabel: '01',
        optionChips: ['Oat Milk', 'Large'],
        icon: Icons.local_cafe_outlined,
        palette: [Color(0xFF6D584B), Color(0xFFB29882), Color(0xFFE7DBD0)],
      ),
      GrabAndGoCartItemData(
        title: 'Cold Brew Reserve',
        price: '\$6.00',
        quantityLabel: '01',
        optionChips: ['Black', 'Medium'],
        icon: Icons.water_drop_outlined,
        palette: [Color(0xFF3A2E28), Color(0xFF7A6457), Color(0xFFD8C6B9)],
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GrabAndGoCartHeaderSection(),
                  const SizedBox(height: 28),
                  for (var i = 0; i < items.length; i++) ...[
                    GrabAndGoCartItemCard(data: items[i]),
                    if (i != items.length - 1) const SizedBox(height: 20),
                  ],
                  const SizedBox(height: 36),
                  GrabAndGoCartSummaryCard(
                    subtotal: '\$13.50',
                    brewingFee: '\$0.50',
                    total: '\$14.00',
                    onProceedToCheckoutTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder<void>(
                          transitionDuration: const Duration(milliseconds: 180),
                          reverseTransitionDuration: const Duration(
                            milliseconds: 140,
                          ),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const GrabAndGoCheckoutScreen(),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ShellBottomBar(
        activeTab: AppNavTab.grabAndGo,
        currentTab: null,
      ),
    );
  }
}
