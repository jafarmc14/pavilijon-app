import 'package:flutter/material.dart';
import 'package:pavilijon_app/widgets/grab_and_go/grab_and_go_menu_card.dart';
import 'package:pavilijon_app/widgets/grab_and_go_variant/grab_and_go_variant_widgets.dart';

Future<void> showGrabAndGoVariantPickerSheet(
  BuildContext context, {
  required GrabAndGoItemData item,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Close variant picker',
    barrierColor: Colors.black.withValues(alpha: 0.44),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, animation, secondaryAnimation) {
      return _GrabAndGoVariantPickerSheet(item: item);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.08),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class _GrabAndGoVariantPickerSheet extends StatelessWidget {
  const _GrabAndGoVariantPickerSheet({required this.item});

  final GrabAndGoItemData item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const SizedBox.expand(),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(color: Color(0xFFF9F9F9)),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF1A1A1A),
                                    Color(0xFF161616),
                                    Color(0xFFF9F9F9),
                                    Color(0xFFF9F9F9),
                                  ],
                                  stops: [0, 0.34, 0.34, 1],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  18,
                                  18,
                                  18,
                                  0,
                                ),
                                child: Row(
                                  children: [
                                    _SheetIconButton(
                                      icon: Icons.arrow_back_rounded,
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'KURASU TOKYO',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 1.4,
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(width: 52),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.fromLTRB(
                                    20,
                                    18,
                                    20,
                                    140,
                                  ),
                                  child: Column(
                                    children: [
                                      GrabAndGoVariantHero(item: item),
                                      const SizedBox(height: 24),
                                      Container(
                                        width: 48,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFFADB3B4,
                                          ).withValues(alpha: 0.3),
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      GrabAndGoVariantSheet(item: item),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: GrabAndGoVariantBottomAction(
                              totalPrice: item.variantTotalPrice,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetIconButton extends StatelessWidget {
  const _SheetIconButton({required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onPressed ?? () {},
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
