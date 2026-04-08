import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';
import 'package:pavilijon_app/widgets/store_payment_success/store_payment_success_widgets.dart';

class StorePaymentSuccessScreen extends StatelessWidget {
  const StorePaymentSuccessScreen({super.key});

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
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: Column(
                    children: [
                      const StorePaymentSuccessHeader(),
                      const SizedBox(height: 32),
                      const StorePaymentSuccessOrderCard(),
                      const SizedBox(height: 28),
                      const StorePaymentSuccessActions(),
                    ],
                  ),
                ),
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
