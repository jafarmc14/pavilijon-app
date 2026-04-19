import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      const _TermsSectionData(
        title: '1. Company Information',
        body: 'This store is operated by:',
        bullets: [
          'Company Name: PAVILIJON FOODSKA GLOBAL Sp. z o.o.',
          'NIP: 5253076786',
          'REGON: 54384483200000',
          'Address: ul. ALEJA "SOLIDARNOSCI" 60B/U3, 00-240 WARSZAWA, Poland',
          'Email: admin@pavilijoncoffee.com',
          'Phone: +48 452 211 208',
        ],
      ),
      const _TermsSectionData(
        title: '2. General Provisions',
        body:
            'These Terms & Conditions define the rules for making purchases in the Pavilijon Coffee online store. By placing an order, the Customer confirms that they have read and agree to these Terms.',
      ),
      const _TermsSectionData(
        title: '3. Orders and Payment',
        body:
            'All prices listed on the website are gross prices in Polish Zloty (PLN) and include applicable VAT. Payments for online orders are processed securely via the PayU payment gateway. Orders are fulfilled once payment is successfully received.',
      ),
      const _TermsSectionData(
        title: '4. Delivery and Collection',
        body:
            'Products are prepared according to the selected collection or delivery method. Customers are responsible for providing accurate contact and delivery information.',
      ),
      const _TermsSectionData(
        title: '5. Returns and Complaints',
        body:
            'Due to the perishable nature of food and beverage goods, rights to return standard products may be limited. If an item is defective or an error has occurred, please contact us immediately via the email or phone number provided above.',
      ),
      const _TermsSectionData(
        title: '6. Privacy Policy',
        body:
            'The Seller processes the Customer\'s personal data solely for the purpose of fulfilling the contract (order). Detailed information is available in our Privacy Policy.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Stack(
        children: [
          Positioned(
            top: 180,
            left: -90,
            child: IgnorePointer(
              child: Text(
                'CEREMONY',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 160,
                  height: 1,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2D3435).withValues(alpha: 0.03),
                  letterSpacing: -6,
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
                expandedHeight: 72,
                toolbarHeight: 72,
                flexibleSpace: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: ColoredBox(
                      color: const Color(0xFFF9F9F9).withValues(alpha: 0.74),
                    ),
                  ),
                ),
                titleSpacing: 0,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Terms & Conditions (Regulamin)',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                        color: const Color(0xFF17191A),
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
                      Text(
                        'AGREEMENT',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF815534),
                          fontSize: 10,
                          letterSpacing: 2.4,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Terms & Conditions\n(Regulamin)',
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              height: 0.95,
                              letterSpacing: -1.8,
                              color: const Color(0xFF17191A),
                            ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Last Updated: March 2026',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                              color: const Color(0xFF5F5E5E),
                            ),
                      ),
                      const SizedBox(height: 44),
                      for (final section in sections) ...[
                        _TermsSection(section: section),
                        const SizedBox(height: 44),
                      ],
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 28),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: const Color(
                                0xFFADB3B4,
                              ).withValues(alpha: 0.16),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'END OF DOCUMENT',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  fontSize: 10,
                                  letterSpacing: 2.2,
                                  color: const Color(
                                    0xFF5F5E5E,
                                  ).withValues(alpha: 0.42),
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: ShellBottomBar(activeTab: null, currentTab: null),
    );
  }
}

class _TermsSection extends StatelessWidget {
  const _TermsSection({required this.section});

  final _TermsSectionData section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: const Color(0xFF17191A),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          section.body,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF5A6061),
            height: 1.8,
          ),
        ),
        if (section.bullets.isNotEmpty) ...[
          const SizedBox(height: 18),
          for (var i = 0; i < section.bullets.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 36,
                  child: Text(
                    '${(i + 1).toString().padLeft(2, '0')}',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF815534),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    section.bullets[i],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      height: 1.65,
                      color: const Color(0xFF5A6061),
                    ),
                  ),
                ),
              ],
            ),
            if (i != section.bullets.length - 1) const SizedBox(height: 12),
          ],
        ],
      ],
    );
  }
}

class _TermsSectionData {
  const _TermsSectionData({
    required this.title,
    required this.body,
    this.bullets = const [],
  });

  final String title;
  final String body;
  final List<String> bullets;
}
