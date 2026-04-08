import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';
import 'package:pavilijon_app/screens/store_cart_screen.dart';
import 'package:pavilijon_app/widgets/store/store_widgets.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const products = [
      StoreProductData(
        category: 'Ethiopia Yirgacheffe',
        title: 'Floral Ceremony Roast',
        description:
            'A delicate profile featuring notes of jasmine, bergamot, and sweet peach. Roasted for clarity.',
        price: '\$34.00',
        icon: Icons.local_cafe_outlined,
        palette: [Color(0xFF2A201C), Color(0xFF5B4638), Color(0xFFBBAA96)],
        surfaceColor: Color(0xFFFFFFFF),
        badge: 'New Arrival',
        imageAlignment: Alignment(0.62, -0.08),
      ),
      StoreProductData(
        category: 'Tools of the Craft',
        title: 'Precision Manual Press',
        description:
            'Full control over pressure profiling. Engineered for the purist who seeks tactile perfection.',
        price: '\$249.00',
        icon: Icons.coffee_maker_outlined,
        palette: [Color(0xFF3D4247), Color(0xFF808890), Color(0xFFD7DADD)],
        surfaceColor: Color(0xFFF2F4F4),
        imageAlignment: Alignment(0.6, -0.05),
      ),
      StoreProductData(
        category: 'Vessel',
        title: 'Wabi-Sabi Ceramic Set',
        description:
            'Hand-thrown in Gifu, Japan. Each piece carries unique imperfections and a story of fire.',
        price: '\$42.00',
        icon: Icons.emoji_food_beverage_outlined,
        palette: [Color(0xFF6F5A4D), Color(0xFFA58C78), Color(0xFFE1D4C9)],
        surfaceColor: Color(0xFFF2F4F4),
        badge: 'Limited Edition',
        badgeColor: Color(0xFF9F403D),
        badgeTextColor: Color(0xFFFFF7F6),
        badgeAtBottom: true,
        imageAlignment: Alignment(0.56, 0.02),
      ),
      StoreProductData(
        category: 'Signature Blend',
        title: 'The Silent Nocturne',
        description:
            'Deep chocolate tones with a hint of toasted almond. Perfect for the late hours of reflection.',
        price: '\$28.00',
        icon: Icons.blur_on_outlined,
        palette: [Color(0xFF2A201C), Color(0xFF5B4638), Color(0xFFC0AD97)],
        surfaceColor: Color(0xFFFFFFFF),
        imageAlignment: Alignment(0.54, -0.08),
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
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 220),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const StoreHeaderSection(),
                      const SizedBox(height: 28),
                      const StoreFilterChips(),
                      const SizedBox(height: 28),
                      StoreProductGrid(products: products),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 104,
            child: StoreFloatingCart(
              itemCount: 2,
              totalAmount: '\$283.00',
              onReviewOrderTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder<void>(
                    transitionDuration: const Duration(milliseconds: 180),
                    reverseTransitionDuration: const Duration(
                      milliseconds: 140,
                    ),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const StoreCartScreen(),
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
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavBar(
        activeTab: AppNavTab.store,
        currentTab: AppNavTab.store,
      ),
    );
  }
}
