import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pavilijon_app/screens/screen_components.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeLocationSection extends StatelessWidget {
  const HomeLocationSection({super.key});

  static const _workshopAddress =
      'ul. ALEJA "SOLIDARNOSCI" 60B/U3, 00-240 WARSZAWA, Poland';

  Future<void> _openWorkshopMap(BuildContext context) async {
    final googleMapsUri = Uri.https('www.google.com', '/maps/search/', {
      'api': '1',
      'query': _workshopAddress,
    });
    final appleMapsUri = Uri.https('maps.apple.com', '/', {
      'q': _workshopAddress,
    });

    final primaryUri = defaultTargetPlatform == TargetPlatform.iOS
        ? appleMapsUri
        : googleMapsUri;
    final fallbackUri = defaultTargetPlatform == TargetPlatform.iOS
        ? googleMapsUri
        : appleMapsUri;

    try {
      if (await launchUrl(primaryUri, mode: LaunchMode.externalApplication)) {
        return;
      }

      if (await launchUrl(fallbackUri, mode: LaunchMode.externalApplication)) {
        return;
      }
    } on MissingPluginException catch (error, stackTrace) {
      debugPrint(
        '[Location] url_launcher plugin is not registered yet: $error',
      );
      debugPrintStack(stackTrace: stackTrace);
    } on PlatformException catch (error, stackTrace) {
      debugPrint('[Location] Failed to open maps via platform channel: $error');
      debugPrintStack(stackTrace: stackTrace);
    }

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Unable to open maps on this device right now.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 720;
        final openingState = _WorkshopOpeningState.now();
        final details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'THE WORKSHOP',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFF815534),
                fontSize: 10,
                letterSpacing: 2.2,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Warszawa, Poland',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF17191A),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'ul. ALEJA "SOLIDARNOSCI" 60B/U3\n00-240 WARSZAWA\nPoland',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF5A6061),
                height: 1.55,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: openingState.isOpen
                        ? const Color(0xFF2FB45A)
                        : const Color(0xFF9F403D),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  openingState.label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 13,
                    letterSpacing: 0,
                    color: const Color(0xFF17191A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'Hours',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFF815534),
                fontSize: 10,
                letterSpacing: 2.2,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            _HoursRow(days: 'Mon - Fri', hours: '07:00 - 19:00'),
            const SizedBox(height: 8),
            _HoursRow(days: 'Sat - Sun', hours: '08:00 - 20:00'),
          ],
        );

        final mapWithPin = Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () => _openWorkshopMap(context),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const _LocationMapPreview(),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.04),
                            Colors.black.withValues(alpha: 0.1),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: Color(0xFF815534),
                        size: 28,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 18,
                    right: 18,
                    bottom: 18,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Open In Maps',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: const Color(0xFF815534),
                                        fontSize: 10,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Navigate to The Workshop',
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(
                                        color: const Color(0xFF17191A),
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF17191A),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.arrow_outward_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: details),
              const SizedBox(width: 24),
              Expanded(
                flex: 2,
                child: SizedBox(height: 340, child: mapWithPin),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            details,
            const SizedBox(height: 20),
            SizedBox(height: 240, child: mapWithPin),
          ],
        );
      },
    );
  }
}

class _LocationMapPreview extends StatelessWidget {
  const _LocationMapPreview();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(28)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: const [
                  Color(0xFFF7F4EF),
                  Color(0xFFE8E1D8),
                  Color(0xFFF4EEE7),
                ],
                stops: const [0.0, 0.55, 1.0],
              ),
            ),
          ),
          Positioned.fill(child: CustomPaint(painter: _StaticMapPainter())),
          Positioned(
            top: 18,
            left: 18,
            child: _MapLabelChip(label: 'ALEJA SOLIDARNOSCI', emphasized: true),
          ),
          const Positioned(
            top: 70,
            right: 22,
            child: _MapLabelChip(label: 'OLD TOWN'),
          ),
          const Positioned(
            bottom: 96,
            left: 22,
            child: _MapLabelChip(label: 'MURANOW'),
          ),
          Positioned(
            top: 36,
            right: 30,
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF815534).withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 8,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 94,
                    height: 94,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF815534).withValues(alpha: 0.10),
                    ),
                  ),
                  Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF815534).withValues(alpha: 0.14),
                    ),
                  ),
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.10),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Color(0xFF815534),
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HoursRow extends StatelessWidget {
  const _HoursRow({required this.days, required this.hours});

  final String days;
  final String hours;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            days,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF17191A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          hours,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF5A6061),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _MapLabelChip extends StatelessWidget {
  const _MapLabelChip({required this.label, this.emphasized = false});

  final String label;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: emphasized
            ? Colors.white.withValues(alpha: 0.96)
            : Colors.white.withValues(alpha: 0.74),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFDDD2C7)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: emphasized ? const Color(0xFF815534) : const Color(0xFF5A6061),
          fontSize: 9,
          letterSpacing: 1.6,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _WorkshopOpeningState {
  const _WorkshopOpeningState({required this.isOpen, required this.label});

  final bool isOpen;
  final String label;

  factory _WorkshopOpeningState.now() {
    final now = DateTime.now();
    final weekday = now.weekday;
    final totalMinutes = now.hour * 60 + now.minute;

    final isWeekend =
        weekday == DateTime.saturday || weekday == DateTime.sunday;
    final opensAt = isWeekend ? 8 * 60 : 7 * 60;
    final closesAt = isWeekend ? 20 * 60 : 19 * 60;
    final isOpen = totalMinutes >= opensAt && totalMinutes < closesAt;

    return _WorkshopOpeningState(
      isOpen: isOpen,
      label: isOpen ? 'Currently Open' : 'Currently Closed',
    );
  }
}

class _StaticMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.95)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final minorRoadPaint = Paint()
      ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.72)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final blockPaint = Paint()
      ..color = const Color(0xFFD8CEC3).withValues(alpha: 0.55)
      ..style = PaintingStyle.fill;

    final blocks = [
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.06, size.height * 0.18, 78, 54),
        const Radius.circular(16),
      ),
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.68, size.height * 0.16, 90, 66),
        const Radius.circular(18),
      ),
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.18, size.height * 0.62, 110, 72),
        const Radius.circular(22),
      ),
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.66, size.height * 0.58, 84, 58),
        const Radius.circular(18),
      ),
    ];

    for (final block in blocks) {
      canvas.drawRRect(block, blockPaint);
    }

    roadPaint.strokeWidth = 24;
    minorRoadPaint.strokeWidth = 14;

    final avenue = Path()
      ..moveTo(size.width * 0.02, size.height * 0.30)
      ..quadraticBezierTo(
        size.width * 0.28,
        size.height * 0.34,
        size.width * 0.52,
        size.height * 0.48,
      )
      ..quadraticBezierTo(
        size.width * 0.72,
        size.height * 0.58,
        size.width * 1.02,
        size.height * 0.66,
      );
    canvas.drawPath(avenue, roadPaint);

    final crossStreet = Path()
      ..moveTo(size.width * 0.58, -10)
      ..quadraticBezierTo(
        size.width * 0.56,
        size.height * 0.28,
        size.width * 0.48,
        size.height * 0.52,
      )
      ..quadraticBezierTo(
        size.width * 0.44,
        size.height * 0.68,
        size.width * 0.38,
        size.height + 10,
      );
    canvas.drawPath(crossStreet, minorRoadPaint);

    final minorStreet = Path()
      ..moveTo(size.width * 0.10, size.height * 0.82)
      ..quadraticBezierTo(
        size.width * 0.32,
        size.height * 0.72,
        size.width * 0.56,
        size.height * 0.74,
      )
      ..quadraticBezierTo(
        size.width * 0.78,
        size.height * 0.76,
        size.width * 0.92,
        size.height * 0.86,
      );
    canvas.drawPath(minorStreet, minorRoadPaint);

    final routePaint = Paint()
      ..color = const Color(0xFF815534).withValues(alpha: 0.34)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final route = Path()
      ..moveTo(size.width * 0.20, size.height * 0.18)
      ..quadraticBezierTo(
        size.width * 0.34,
        size.height * 0.36,
        size.width * 0.49,
        size.height * 0.50,
      );
    canvas.drawPath(route, routePaint);

    final routeDotPaint = Paint()
      ..color = const Color(0xFF815534)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width * 0.49, size.height * 0.50),
      5,
      routeDotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
