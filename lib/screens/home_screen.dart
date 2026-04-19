import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/data/homepage_content.dart';
import 'package:pavilijon_app/screens/loyalty_registration_screen.dart';
import 'package:pavilijon_app/screens/screen_components.dart';
import 'package:pavilijon_app/screens/terms_conditions_screen.dart';
import 'package:pavilijon_app/widgets/home/home_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homepageContent = HomepageContentStore.instance.content;
    final signatureMenu = homepageContent?.signatureMenu ?? const [];

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
                  HomeHeroBanner(
                    imageUrls: homepageContent?.heroImages ?? const [],
                  ),
                  const SizedBox(height: 44),
                  const HomeSectionHeading(
                    eyebrow: 'Featured Brews',
                    title: 'The Signature Collection',
                  ),
                  const SizedBox(height: 18),
                  if (signatureMenu.isEmpty)
                    Container(
                      height: 220,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F4F4),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Text(
                        'Signature collection is being prepared.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF5A6061),
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      height: 392,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: signatureMenu.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 20),
                        itemBuilder: (context, index) {
                          return FeaturedBrewCard(data: signatureMenu[index]);
                        },
                      ),
                    ),
                  const SizedBox(height: 52),
                  HomeStorySection(
                    imageUrls: homepageContent?.storyImages ?? const [],
                  ),
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
      bottomNavigationBar: const AppBottomNavBar(
        activeTab: AppNavTab.home,
        currentTab: AppNavTab.home,
      ),
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
