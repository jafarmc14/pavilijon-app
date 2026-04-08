import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';
import 'package:pavilijon_app/widgets/grab_and_go_payment_success/grab_and_go_payment_success_widgets.dart';

class GrabAndGoPaymentSuccessScreen extends StatelessWidget {
  const GrabAndGoPaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width * 0.34,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF815534).withValues(alpha: 0.02),
                      const Color(0xFF815534).withValues(alpha: 0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
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
                      HeaderIconButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: () {
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'KURASU',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.4,
                                color: const Color(0xFF17191A),
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
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 460),
                      child: Column(
                        children: [
                          const GrabAndGoPaymentSuccessVisual(),
                          const SizedBox(height: 28),
                          Text(
                            'TRANSACTION CONFIRMED',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  fontSize: 12,
                                  letterSpacing: 1.8,
                                  color: const Color(0xFF815534),
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Your Ritual is Brewing',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -1.2,
                                  color: const Color(0xFF2D3435),
                                ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "We'll notify you when your ceremony is ready.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  height: 1.6,
                                  color: const Color(0xFF5A6061),
                                ),
                          ),
                          const SizedBox(height: 32),
                          const GrabAndGoPaymentSuccessStatusCard(),
                          const SizedBox(height: 28),
                          Opacity(
                            opacity: 0.45,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: const Color(0xFFADB3B4),
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  'THANK YOU FOR CHOOSING KURASU.\nA DIGITAL RECEIPT HAS BEEN SENT TO YOUR INBOX.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        fontSize: 10,
                                        height: 1.8,
                                        letterSpacing: 1.6,
                                        color: const Color(0xFF535252),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
