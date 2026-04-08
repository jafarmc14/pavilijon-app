import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/grab_and_go_payment_success_screen.dart';
import 'package:pavilijon_app/screens/screen_components.dart';
import 'package:pavilijon_app/widgets/grab_and_go_checkout/grab_and_go_checkout_widgets.dart';

class GrabAndGoCheckoutScreen extends StatelessWidget {
  const GrabAndGoCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: Stack(
                children: [
                  Positioned(
                    left: -120,
                    top: -80,
                    child: Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF815534).withValues(alpha: 0.05),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -80,
                    top: 360,
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE4E9EA).withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                      const SizedBox(width: 52),
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
                      final isWide = constraints.maxWidth > 980;

                      if (isWide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Expanded(child: GrabAndGoCheckoutFormSection()),
                            SizedBox(width: 36),
                            SizedBox(
                              width: 360,
                              child: _GrabAndGoCheckoutPane(),
                            ),
                          ],
                        );
                      }

                      return const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GrabAndGoCheckoutFormSection(),
                          SizedBox(height: 32),
                          _GrabAndGoCheckoutPane(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
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

class _GrabAndGoCheckoutPane extends StatelessWidget {
  const _GrabAndGoCheckoutPane();

  @override
  Widget build(BuildContext context) {
    return GrabAndGoCheckoutSummaryCard(
      onFinalizeRitualTap: () {
        Navigator.of(context).push(
          PageRouteBuilder<void>(
            transitionDuration: const Duration(milliseconds: 180),
            reverseTransitionDuration: const Duration(milliseconds: 140),
            pageBuilder: (context, animation, secondaryAnimation) =>
                const GrabAndGoPaymentSuccessScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final curved = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                    reverseCurve: Curves.easeInCubic,
                  );
                  return FadeTransition(opacity: curved, child: child);
                },
          ),
        );
      },
    );
  }
}
