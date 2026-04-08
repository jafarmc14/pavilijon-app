import 'package:flutter/material.dart';

class GrabAndGoCheckoutFormSection extends StatelessWidget {
  const GrabAndGoCheckoutFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STEP 01',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: 11,
            letterSpacing: 2.2,
            color: const Color(0xFF815534),
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Personal Ritual',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -1.5,
            color: const Color(0xFF2D3435),
          ),
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 520;

            final nameField = _CheckoutField(
              label: 'Full Name',
              child: TextFormField(
                initialValue: 'Kenji Tanaka',
                decoration: _checkoutDecoration('Kenji Tanaka'),
              ),
            );

            final phoneField = _CheckoutField(
              label: 'Phone Number',
              child: TextFormField(
                initialValue: '+81 90-1234-5678',
                decoration: _checkoutDecoration('+81 90-1234-5678'),
              ),
            );

            return Column(
              children: [
                if (isWide)
                  Row(
                    children: [
                      Expanded(child: nameField),
                      const SizedBox(width: 20),
                      Expanded(child: phoneField),
                    ],
                  )
                else ...[
                  nameField,
                  const SizedBox(height: 18),
                  phoneField,
                ],
                const SizedBox(height: 18),
                _CheckoutField(
                  label: 'Email Address',
                  child: TextFormField(
                    initialValue: 'k.tanaka@ritual.jp',
                    decoration: _checkoutDecoration('k.tanaka@ritual.jp'),
                  ),
                ),
                const SizedBox(height: 18),
                _CheckoutField(
                  label: 'Special Notes',
                  child: TextFormField(
                    initialValue:
                        'Notes for the barista (e.g., extra hot, oat milk preference)...',
                    minLines: 3,
                    maxLines: 3,
                    decoration: _checkoutDecoration(
                      'Notes for the barista (e.g., extra hot, oat milk preference)...',
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 44),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F4F4),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -30,
                bottom: -38,
                child: Icon(
                  Icons.workspace_premium_rounded,
                  size: 150,
                  color: const Color(0xFF2D3435).withValues(alpha: 0.04),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.workspace_premium_rounded,
                        color: Color(0xFF815534),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'LOYALTY VALIDATION',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.2,
                                color: const Color(0xFF2D3435),
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Enter your Ceremony ID to apply rewards and earn 12 beans on this order.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                      color: const Color(0xFF5A6061),
                    ),
                  ),
                  const SizedBox(height: 18),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final stacked = constraints.maxWidth < 460;

                      final input = Expanded(
                        child: TextFormField(
                          initialValue: 'Member ID #8821',
                          decoration: _checkoutDecoration('Member ID #8821'),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                letterSpacing: 0,
                                color: const Color(0xFF2D3435),
                              ),
                        ),
                      );

                      final button = FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF815534),
                          foregroundColor: const Color(0xFFFFF7F4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: Text(
                          'VALIDATE',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontSize: 11,
                                letterSpacing: 1.5,
                                color: const Color(0xFFFFF7F4),
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      );

                      if (stacked) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(children: [input]),
                            const SizedBox(height: 12),
                            button,
                          ],
                        );
                      }

                      return Row(
                        children: [input, const SizedBox(width: 12), button],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CheckoutField extends StatelessWidget {
  const _CheckoutField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 8),
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              letterSpacing: 1.8,
              color: const Color(0xFF757C7D),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

InputDecoration _checkoutDecoration(String hintText) {
  return InputDecoration(
    filled: true,
    fillColor: const Color(0xFFF2F4F4),
    hintText: hintText,
    hintStyle: const TextStyle(color: Color(0xFF9C9D9D)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0x4DADB3B4)),
      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF815534), width: 1.2),
      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
    ),
  );
}
