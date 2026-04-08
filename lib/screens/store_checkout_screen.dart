import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';
import 'package:pavilijon_app/screens/store_payment_success_screen.dart';
import 'package:pavilijon_app/widgets/store_checkout/store_checkout_widgets.dart';

class StoreCheckoutScreen extends StatelessWidget {
  const StoreCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  HeaderIconButton(
                    icon: Icons.close_rounded,
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  const SizedBox(width: 12),
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(22),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'SECURE CHECKOUT',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 10,
                    letterSpacing: 1.8,
                    color: const Color(0xFF9C9D9D),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 920;

                  final summarySection = StoreCheckoutSummaryCard(
                    onPayNowTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder<void>(
                          transitionDuration: const Duration(milliseconds: 180),
                          reverseTransitionDuration: const Duration(
                            milliseconds: 140,
                          ),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const StorePaymentSuccessScreen(),
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
                        const Expanded(
                          flex: 7,
                          child: StoreCheckoutFormSection(),
                        ),
                        const SizedBox(width: 32),
                        Expanded(flex: 5, child: summarySection),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const StoreCheckoutFormSection(),
                      const SizedBox(height: 32),
                      summarySection,
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
