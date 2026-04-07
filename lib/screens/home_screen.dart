import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/loyalty_registration_screen.dart';
import 'package:pavilijon_app/screens/screen_components.dart';
import 'package:pavilijon_app/screens/terms_conditions_screen.dart';
import 'package:pavilijon_app/widgets/home/home_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final featuredBrews = [
      const FeaturedBrewData(
        title: 'Onyx Cold Brew',
        description: 'Notes of dark chocolate and smoke',
        price: '\$7.50',
        icon: Icons.dark_mode_outlined,
        palette: [Color(0xFF30211A), Color(0xFF6D4C39)],
      ),
      const FeaturedBrewData(
        title: 'Kyoto Matcha Ritual',
        description: 'Stone-ground, ceremonial grade',
        price: '\$9.00',
        icon: Icons.spa_outlined,
        palette: [Color(0xFF4C6B3C), Color(0xFF8EA86A)],
      ),
      const FeaturedBrewData(
        title: 'Cloud Foam Latte',
        description: 'Oat milk, vanilla bean infusion',
        price: '\$6.50',
        icon: Icons.cloud_outlined,
        palette: [Color(0xFF786555), Color(0xFFD8C4AF)],
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            toolbarHeight: 72,
            expandedHeight: 102,
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: ColoredBox(color: Colors.white.withValues(alpha: 0.72)),
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(26),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Tokyo Roasted / Kyoto Brewed',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: const Color(0xFF9C9D9D),
                    fontSize: 10,
                    letterSpacing: 2.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeHeroBanner(),
                  const SizedBox(height: 44),
                  const HomeSectionHeading(
                    eyebrow: 'Featured Brews',
                    title: 'The Signature Collection',
                    actionLabel: 'View All',
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 392,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredBrews.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 20),
                      itemBuilder: (context, index) {
                        return FeaturedBrewCard(data: featuredBrews[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 52),
                  const HomeStorySection(),
                  const SizedBox(height: 40),
                  HomeLoyaltyBanner(
                    onBecomeMemberTap: () {
                      _pushLightRoute(
                        context,
                        const LoyaltyRegistrationScreen(),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  const HomeLocationSection(),
                  const SizedBox(height: 40),
                  HomeTermsEntryCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const TermsConditionsScreen(),
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
      bottomNavigationBar: const HomeBottomNavBar(),
    );
  }
}

Future<T?> _pushLightRoute<T>(BuildContext context, Widget page) {
  return Navigator.of(context).push<T>(
    PageRouteBuilder<T>(
      transitionDuration: const Duration(milliseconds: 180),
      reverseTransitionDuration: const Duration(milliseconds: 140),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(opacity: curved, child: child);
      },
    ),
  );
}
