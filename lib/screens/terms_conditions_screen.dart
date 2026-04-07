import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      const _TermsSectionData(
        title: '1. Acceptance of Terms',
        body:
            'By entering the digital space of The Silent Ceremony, you acknowledge that you have read, understood, and agreed to be bound by these terms. This is a ritual of mutual respect and precision. If you do not agree to these terms, we invite you to cease your journey through our platform immediately.',
        quote:
            'Precision is the foundation of the ritual. Every interaction is measured, every drop is counted.',
      ),
      const _TermsSectionData(
        title: '2. User Eligibility',
        body:
            'Membership within our community is reserved for individuals who have reached the age of majority in their jurisdiction. You must provide accurate, truthful information when creating your profile. We reserve the right to suspend any account that fails to maintain the integrity of the ritual.',
        bullets: [
          'Global residency compliance is required for physical deliveries.',
          'Single-user authentication protocols must be observed.',
        ],
      ),
      const _TermsSectionData(
        title: '3. Ritual Services',
        body:
            'Our services encompass the curation, roasted preparation, and delivery of premium beans. Each Brew Card displayed represents a unique temporal offering. Prices are subject to change based on seasonal harvest availability and the technical precision required for each batch.',
      ),
      const _TermsSectionData(
        title: '4. Intellectual Property',
        body:
            'All visual aesthetics, typography pairings, and the proprietary Silent Ceremony brewing techniques are protected. You may not reproduce, replicate, or mirror the editorial layout of this interface for any commercial purpose without explicit written consent.',
      ),
      const _TermsSectionData(
        title: '5. Limitation of Liability',
        body:
            'We strive for perfection, yet acknowledge the variables of the natural world. The Silent Ceremony shall not be liable for any indirect, incidental, or consequential damages resulting from your use or inability to use our services.',
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
                      'Terms & Conditions',
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
                        'The Terms of\nOur Silent Ceremony.',
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              height: 0.95,
                              letterSpacing: -1.8,
                              color: const Color(0xFF17191A),
                            ),
                      ),
                      const SizedBox(height: 18),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        runSpacing: 6,
                        children: [
                          Text(
                            'Last Updated: OCTOBER 24, 2023',
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                  color: const Color(0xFF5F5E5E),
                                ),
                          ),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: Color(0xFFADB3B4),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            'v 2.1.0',
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF5F5E5E),
                                ),
                          ),
                        ],
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
      bottomNavigationBar: ShellBottomBar(
        onHomeTap: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      ),
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
        if (section.quote != null) ...[
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '"${section.quote!}"',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: const Color(0xFF5A6061),
              ),
            ),
          ),
        ],
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
    this.quote,
    this.bullets = const [],
  });

  final String title;
  final String body;
  final String? quote;
  final List<String> bullets;
}
