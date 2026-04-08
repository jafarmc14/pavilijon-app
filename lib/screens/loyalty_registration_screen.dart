import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';

class LoyaltyRegistrationScreen extends StatefulWidget {
  const LoyaltyRegistrationScreen({super.key});

  @override
  State<LoyaltyRegistrationScreen> createState() =>
      _LoyaltyRegistrationScreenState();
}

class _LoyaltyRegistrationScreenState extends State<LoyaltyRegistrationScreen> {
  final List<String> _genderOptions = const [
    'Prefer not to say',
    'Non-binary',
    'Female',
    'Male',
  ];
  final List<String> _originOptions = const [
    'Kyoto Dark Roast',
    'Ethiopian Yirgacheffe',
    'Cold Brew Concentrate',
    'Signature Matcha Ritual',
  ];

  String _selectedGender = 'Prefer not to say';
  String _selectedOrigin = 'Kyoto Dark Roast';

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
            flexibleSpace: const ColoredBox(color: Color(0xFFF9F9F9)),
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
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 11,
                        letterSpacing: 2.2,
                        fontWeight: FontWeight.w800,
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
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 780;

                      final heroLeft = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MEMBERSHIP INVITATION',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: const Color(0xFF815534),
                                  fontSize: 10,
                                  letterSpacing: 2.6,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Join the\nRitual.',
                            style: Theme.of(context).textTheme.displayLarge
                                ?.copyWith(
                                  fontSize: isWide ? 82 : 60,
                                  height: 0.94,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -2.8,
                                  color: const Color(0xFF17191A),
                                ),
                          ),
                        ],
                      );

                      final heroRight = Text(
                        'Step beyond the counter. Our loyalty program is a curated path for the discerning palate, where every brew tells a story of celestial timing.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                          height: 1.7,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFF5A6061),
                        ),
                      );

                      if (isWide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(flex: 7, child: heroLeft),
                            const SizedBox(width: 28),
                            Expanded(flex: 5, child: heroRight),
                          ],
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heroLeft,
                          const SizedBox(height: 20),
                          heroRight,
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 44),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 820),
                      child: _LoyaltyRegistrationForm(
                        selectedGender: _selectedGender,
                        selectedOrigin: _selectedOrigin,
                        genderOptions: _genderOptions,
                        originOptions: _originOptions,
                        onGenderChanged: (value) {
                          if (value == null) return;
                          setState(() => _selectedGender = value);
                        },
                        onOriginChanged: (value) {
                          if (value == null) return;
                          setState(() => _selectedOrigin = value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ShellBottomBar(activeTab: null, currentTab: null),
    );
  }
}

class _LoyaltyRegistrationForm extends StatelessWidget {
  const _LoyaltyRegistrationForm({
    required this.selectedGender,
    required this.selectedOrigin,
    required this.genderOptions,
    required this.originOptions,
    required this.onGenderChanged,
    required this.onOriginChanged,
  });

  final String selectedGender;
  final String selectedOrigin;
  final List<String> genderOptions;
  final List<String> originOptions;
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<String?> onOriginChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F4),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 560;

              final firstRow = [
                Expanded(
                  child: _LoyaltyField(
                    label: 'Full Name',
                    child: TextFormField(
                      initialValue: 'ALEX MERCER',
                      decoration: _loyaltyInputDecoration('ALEX MERCER'),
                    ),
                  ),
                ),
                Expanded(
                  child: _LoyaltyField(
                    label: 'Email Address',
                    child: TextFormField(
                      initialValue: 'ritual@silent.com',
                      decoration: _loyaltyInputDecoration('ritual@silent.com'),
                    ),
                  ),
                ),
              ];

              final secondRow = [
                Expanded(
                  child: _LoyaltyField(
                    label: 'Date of Birth',
                    child: TextFormField(
                      initialValue: '1994-10-24',
                      decoration: _loyaltyInputDecoration('1994-10-24'),
                    ),
                  ),
                ),
                Expanded(
                  child: _LoyaltyField(
                    label: 'Gender Identification',
                    child: DropdownButtonFormField<String>(
                      value: selectedGender,
                      decoration: _loyaltyInputDecoration(''),
                      items: genderOptions
                          .map(
                            (option) => DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            ),
                          )
                          .toList(),
                      onChanged: onGenderChanged,
                    ),
                  ),
                ),
              ];

              return Column(
                children: [
                  if (isWide)
                    Row(
                      children: [
                        firstRow[0],
                        const SizedBox(width: 18),
                        firstRow[1],
                      ],
                    )
                  else ...[
                    firstRow[0],
                    const SizedBox(height: 18),
                    firstRow[1],
                  ],
                  const SizedBox(height: 18),
                  if (isWide)
                    Row(
                      children: [
                        secondRow[0],
                        const SizedBox(width: 18),
                        secondRow[1],
                      ],
                    )
                  else ...[
                    secondRow[0],
                    const SizedBox(height: 18),
                    secondRow[1],
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          _LoyaltyField(
            label: 'The Favorite Origin',
            child: DropdownButtonFormField<String>(
              value: selectedOrigin,
              decoration: _loyaltyInputDecoration(''),
              items: originOptions
                  .map(
                    (option) => DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    ),
                  )
                  .toList(),
              onChanged: onOriginChanged,
            ),
          ),
          const SizedBox(height: 28),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.icon(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF17191A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_right_alt_rounded),
              label: Text(
                'BEGIN THE CEREMONY',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontSize: 11,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoyaltyField extends StatelessWidget {
  const _LoyaltyField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14, bottom: 8),
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF757C7D),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

InputDecoration _loyaltyInputDecoration(String hintText) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Color(0xFFB8BCBD),
      fontWeight: FontWeight.w600,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: const BorderSide(color: Color(0x33815534), width: 1.4),
    ),
  );
}
