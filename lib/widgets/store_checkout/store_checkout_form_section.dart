import 'package:flutter/material.dart';

class StoreCheckoutFormSection extends StatelessWidget {
  const StoreCheckoutFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STEP 01',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: 10,
            letterSpacing: 2.0,
            color: const Color(0xFF815534),
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Personal Details',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -1.4,
            color: const Color(0xFF17191A),
          ),
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 520;

            final nameField = _CheckoutField(
              label: 'Full Name',
              child: TextFormField(
                initialValue: 'Hidetoshi Nakata',
                decoration: _checkoutDecoration('Hidetoshi Nakata'),
              ),
            );

            final phoneField = _CheckoutField(
              label: 'Phone Number',
              child: TextFormField(
                initialValue: '+81 90-0000-0000',
                decoration: _checkoutDecoration('+81 90-0000-0000'),
              ),
            );

            return Column(
              children: [
                if (isWide)
                  Row(
                    children: [
                      Expanded(child: nameField),
                      const SizedBox(width: 16),
                      Expanded(child: phoneField),
                    ],
                  )
                else ...[
                  nameField,
                  const SizedBox(height: 16),
                  phoneField,
                ],
                const SizedBox(height: 16),
                _CheckoutField(
                  label: 'Email Address',
                  child: TextFormField(
                    initialValue: 'ceremony@minimal.jp',
                    decoration: _checkoutDecoration('ceremony@minimal.jp'),
                  ),
                ),
                const SizedBox(height: 16),
                _CheckoutField(
                  label: 'Delivery Address',
                  child: TextFormField(
                    initialValue: '1-chome-2-3 Shiba-koen, Minato City, Tokyo',
                    minLines: 3,
                    maxLines: 3,
                    decoration: _checkoutDecoration(
                      '1-chome-2-3 Shiba-koen, Minato City, Tokyo',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _CheckoutField(
                  label: 'Loyalty ID (Optional)',
                  labelColor: const Color(0xFF9C9D9D),
                  child: TextFormField(
                    initialValue: 'CEREMONY-2048',
                    decoration: _checkoutDecoration(
                      'CEREMONY-XXXX',
                      suffixIcon: const Icon(
                        Icons.star_border_rounded,
                        color: Color(0xFFB8BCBD),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _CheckoutField extends StatelessWidget {
  const _CheckoutField({
    required this.label,
    required this.child,
    this.labelColor = const Color(0xFF17191A),
  });

  final String label;
  final Widget child;
  final Color labelColor;

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
              fontSize: 9,
              letterSpacing: 1.8,
              color: labelColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

InputDecoration _checkoutDecoration(String hintText, {Widget? suffixIcon}) {
  return InputDecoration(
    filled: true,
    fillColor: const Color(0xFFF2F4F4),
    hintText: hintText,
    hintStyle: const TextStyle(color: Color(0xFF9C9D9D)),
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: const BorderSide(color: Color(0x1A757C7D)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: const BorderSide(color: Color(0xFF815534), width: 1.2),
    ),
  );
}
