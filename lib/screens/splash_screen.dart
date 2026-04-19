import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';

import 'package:pavilijon_app/config/api_config.dart';
import 'package:flutter/material.dart';
import 'package:pavilijon_app/data/homepage_content.dart';
import 'package:pavilijon_app/screens/home_screen.dart';

typedef HomepageLoader = Future<bool> Function();

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static HomepageLoader? homepageLoaderOverride;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static const _minimumSplashDuration = Duration(seconds: 3);
  static final _homepageUri = Uri.parse(homepageEndpoint);

  late final AnimationController _steamController;
  late final AnimationController _exitController;
  String _statusLabel = 'PREPARING THE RITUAL...';

  @override
  void initState() {
    super.initState();
    _steamController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _startInitialization();
  }

  Future<void> _startInitialization() async {
    final stopwatch = Stopwatch()..start();

    final isHomepageReady = await _prepareInitialData();
    if (!isHomepageReady) {
      return;
    }

    final isConfigurationValid = await _checkInitialConfiguration();

    final remainingDuration = _minimumSplashDuration - stopwatch.elapsed;
    if (remainingDuration > Duration.zero) {
      await Future.delayed(remainingDuration);
    }

    await _playExitTransition();

    if (!mounted) return;

    final nextPage = isConfigurationValid
        ? const HomeScreen()
        : const InitialSetupPage();

    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) => nextPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  Future<bool> _prepareInitialData() async {
    _setStatusLabel('FETCHING HOMEPAGE DATA...');
    HomepageContentStore.instance.clear();

    final overrideLoader = SplashScreen.homepageLoaderOverride;
    if (overrideLoader != null) {
      final isReady = await overrideLoader();
      _setStatusLabel(
        isReady ? 'HOMEPAGE DATA RECEIVED.' : 'FAILED TO LOAD HOMEPAGE DATA.',
      );
      return isReady;
    }

    final client = HttpClient()..connectionTimeout = const Duration(seconds: 6);

    try {
      debugPrint('[Splash] Requesting homepage data from $_homepageUri');

      final request = await client.getUrl(_homepageUri);
      request.headers.set(HttpHeaders.acceptHeader, 'application/json');

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint(
          '[Splash] Homepage API success: ${response.statusCode} '
          '(${responseBody.length} chars)',
        );

        final decoded = jsonDecode(responseBody);
        if (decoded is! Map<String, dynamic>) {
          debugPrint(
            '[Splash] Homepage API returned a non-object JSON payload: '
            '${decoded.runtimeType}',
          );
          _setStatusLabel('HOMEPAGE API RESPONSE IS INVALID.');
          return false;
        }

        HomepageContentStore.instance.replaceFromJson(decoded);
        _setStatusLabel('HOMEPAGE DATA RECEIVED.');
        return true;
      }

      debugPrint(
        '[Splash] Homepage API request failed with status '
        '${response.statusCode}. Body: $responseBody',
      );
      _setStatusLabel('FAILED TO LOAD HOMEPAGE DATA.');
      return false;
    } on SocketException catch (error, stackTrace) {
      debugPrint('[Splash] SocketException while loading homepage: $error');
      debugPrintStack(stackTrace: stackTrace);
      _setStatusLabel('HOMEPAGE API IS UNREACHABLE.');
      return false;
    } on FormatException catch (error, stackTrace) {
      debugPrint('[Splash] FormatException while parsing homepage: $error');
      debugPrintStack(stackTrace: stackTrace);
      _setStatusLabel('HOMEPAGE API RESPONSE IS INVALID.');
      return false;
    } on HttpException catch (error, stackTrace) {
      debugPrint('[Splash] HttpException while loading homepage: $error');
      debugPrintStack(stackTrace: stackTrace);
      _setStatusLabel('HOMEPAGE API RESPONSE IS INVALID.');
      return false;
    } on HandshakeException catch (error, stackTrace) {
      debugPrint('[Splash] HandshakeException while loading homepage: $error');
      debugPrintStack(stackTrace: stackTrace);
      _setStatusLabel('SECURE CONNECTION TO API FAILED.');
      return false;
    } catch (error, stackTrace) {
      debugPrint('[Splash] Unexpected error while loading homepage: $error');
      debugPrintStack(stackTrace: stackTrace);
      _setStatusLabel('UNEXPECTED ERROR WHILE LOADING HOMEPAGE.');
      return false;
    } finally {
      client.close(force: true);
    }
  }

  Future<bool> _checkInitialConfiguration() async {
    _setStatusLabel('CHECKING INITIAL CONFIGURATION...');
    await Future.delayed(const Duration(milliseconds: 900));

    return true;
  }

  void _setStatusLabel(String value) {
    if (!mounted) return;
    setState(() {
      _statusLabel = value;
    });
  }

  Future<void> _playExitTransition() async {
    if (!mounted) return;
    _setStatusLabel('POURING INTO THE NEXT MOMENT...');
    await _exitController.forward();
  }

  @override
  void dispose() {
    _steamController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final topPadding = MediaQuery.paddingOf(context).top;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final exitCurve = CurvedAnimation(
      parent: _exitController,
      curve: Curves.easeInOutCubic,
    );

    return Scaffold(
      body: AnimatedBuilder(
        animation: exitCurve,
        builder: (context, child) {
          final contentOpacity = 1 - exitCurve.value;
          final contentShift = 18 * exitCurve.value;

          return Stack(
            children: [
              _AtmosphericBackground(
                steamAnimation: _steamController,
                exitAnimation: exitCurve,
              ),
              Positioned.fill(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      24,
                      math.max(24, size.height * 0.08 - topPadding),
                      24,
                      math.max(24, size.height * 0.06 - bottomPadding),
                    ),
                    child: Transform.translate(
                      offset: Offset(0, contentShift),
                      child: Opacity(
                        opacity: contentOpacity.clamp(0, 1),
                        child: Column(
                          children: [
                            const Spacer(),
                            _BrandBlock(theme: theme),
                            const Spacer(),
                            _LoadingSection(
                              controller: _steamController,
                              theme: theme,
                              exitProgress: exitCurve.value,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _statusLabel,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AtmosphericBackground extends StatelessWidget {
  const _AtmosphericBackground({
    required this.steamAnimation,
    required this.exitAnimation,
  });

  final Animation<double> steamAnimation;
  final Animation<double> exitAnimation;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF7F5F2), Color(0xFFF4F1ED), Color(0xFFF9F9F9)],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: -40,
            right: -40,
            top: -120,
            child: Container(
              height: 340,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.4),
                  radius: 0.9,
                  colors: [Color(0x40FFFFFF), Color(0x00FFFFFF)],
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.95),
            child: Container(
              width: 320,
              height: 320,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x33FFFFFF), Color(0x00FFFFFF)],
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-0.2, -0.48),
            child: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                  stops: [0.45, 1],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: _HeroCoffeeIllustration(
                steamAnimation: steamAnimation,
                exitAnimation: exitAnimation,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.08),
            child: IgnorePointer(
              child: Container(
                width: 260,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF392A22).withValues(alpha: 0.12),
                      const Color(0xFF392A22).withValues(alpha: 0),
                    ],
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

class _HeroCoffeeIllustration extends StatelessWidget {
  const _HeroCoffeeIllustration({
    required this.steamAnimation,
    required this.exitAnimation,
  });

  final Animation<double> steamAnimation;
  final Animation<double> exitAnimation;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: Listenable.merge([steamAnimation, exitAnimation]),
        builder: (context, _) {
          final exitLift = 24 * exitAnimation.value;
          final exitScale = 1 + (exitAnimation.value * 0.06);
          final exitOpacity = 1 - (exitAnimation.value * 0.3);

          return Transform.translate(
            offset: Offset(0, -exitLift),
            child: Transform.scale(
              scale: exitScale,
              child: Opacity(
                opacity: exitOpacity.clamp(0, 1),
                child: SizedBox(
                  width: 340,
                  height: 420,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          _OrganicSteamRibbon(
                            animation: steamAnimation,
                            width: 110,
                            height: 250,
                            dx: -56,
                            startY: 48,
                            riseDistance: 68,
                            sway: 16,
                            rotation: -0.18,
                            delay: 0.0,
                            opacity: 0.18 + (exitAnimation.value * 0.04),
                          ),
                          _OrganicSteamRibbon(
                            animation: steamAnimation,
                            width: 118,
                            height: 300,
                            dx: -4,
                            startY: 30,
                            riseDistance: 84,
                            sway: 12,
                            rotation: 0.03,
                            delay: 0.18,
                            opacity: 0.21 + (exitAnimation.value * 0.05),
                          ),
                          _OrganicSteamRibbon(
                            animation: steamAnimation,
                            width: 104,
                            height: 230,
                            dx: 52,
                            startY: 58,
                            riseDistance: 58,
                            sway: 18,
                            rotation: 0.22,
                            delay: 0.4,
                            opacity: 0.16 + (exitAnimation.value * 0.03),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        child: _CoffeeCupArtwork(
                          animation: steamAnimation,
                          exitAnimation: exitAnimation,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OrganicSteamRibbon extends StatelessWidget {
  const _OrganicSteamRibbon({
    required this.animation,
    required this.width,
    required this.height,
    required this.dx,
    required this.startY,
    required this.riseDistance,
    required this.sway,
    required this.rotation,
    required this.delay,
    required this.opacity,
  });

  final Animation<double> animation;
  final double width;
  final double height;
  final double dx;
  final double startY;
  final double riseDistance;
  final double sway;
  final double rotation;
  final double delay;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final shifted = (animation.value + delay) % 1.0;
    final curve = Curves.easeInOutSine.transform(shifted);
    final y = startY - (curve * riseDistance);
    final x = dx + math.sin(shifted * math.pi * 2) * sway;
    final scale = 0.9 + (curve * 0.18);
    final fade = (1 - ((shifted - 0.5).abs() * 2)).clamp(0.0, 1.0);
    final steamOpacity = opacity * (0.45 + fade * 0.55);

    return Transform.translate(
      offset: Offset(x, y),
      child: Transform.rotate(
        angle: rotation + math.sin(shifted * math.pi * 2) * 0.05,
        child: Transform.scale(
          scale: scale,
          child: CustomPaint(
            size: Size(width, height),
            painter: _SteamRibbonPainter(
              progress: shifted,
              opacity: steamOpacity,
            ),
          ),
        ),
      ),
    );
  }
}

class _CoffeeCupArtwork extends StatelessWidget {
  const _CoffeeCupArtwork({
    required this.animation,
    required this.exitAnimation,
  });

  final Animation<double> animation;
  final Animation<double> exitAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final bobbing = math.sin(animation.value * math.pi * 2) * 2;
        final exitDip = 8 * exitAnimation.value;

        return Transform.translate(
          offset: Offset(0, bobbing + exitDip),
          child: CustomPaint(
            size: const Size(232, 166),
            painter: _CoffeeCupPainter(
              porcelainTint:
                  0.75 + (math.sin(animation.value * math.pi * 2) * 0.02),
              liquidProgress: animation.value,
              exitProgress: exitAnimation.value,
            ),
          ),
        );
      },
    );
  }
}

class _SteamRibbonPainter extends CustomPainter {
  const _SteamRibbonPainter({required this.progress, required this.opacity});

  final double progress;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final drift = math.sin(progress * math.pi * 2);
    final start = Offset(centerX + drift * 10, size.height);
    final cp1 = Offset(centerX - 20 + drift * 22, size.height * 0.73);
    final cp2 = Offset(centerX + 24 - drift * 18, size.height * 0.48);
    final mid = Offset(centerX - 10 + drift * 16, size.height * 0.32);
    final cp3 = Offset(centerX - 34 - drift * 10, size.height * 0.18);
    final cp4 = Offset(centerX + 26 + drift * 8, size.height * 0.07);
    final end = Offset(centerX + drift * 6, 0);

    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, mid.dx, mid.dy)
      ..cubicTo(cp3.dx, cp3.dy, cp4.dx, cp4.dy, end.dx, end.dy);

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 26
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20)
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.white.withValues(alpha: opacity * 0.34),
          Colors.white.withValues(alpha: opacity * 0.12),
          Colors.white.withValues(alpha: 0),
        ],
      ).createShader(Offset.zero & size);

    final corePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6)
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.white.withValues(alpha: opacity),
          Colors.white.withValues(alpha: opacity * 0.55),
          Colors.white.withValues(alpha: 0),
        ],
      ).createShader(Offset.zero & size);

    final accentPath = Path()
      ..moveTo(start.dx + 14, start.dy - 18)
      ..cubicTo(
        cp1.dx + 18,
        cp1.dy - 4,
        cp2.dx - 10,
        cp2.dy - 20,
        mid.dx + 12,
        mid.dy - 24,
      )
      ..cubicTo(
        cp3.dx + 14,
        cp3.dy - 14,
        cp4.dx - 8,
        cp4.dy - 18,
        end.dx + 8,
        end.dy + 8,
      );

    final accentPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
      ..color = Colors.white.withValues(alpha: opacity * 0.35);

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, corePaint);
    canvas.drawPath(accentPath, accentPaint);
  }

  @override
  bool shouldRepaint(covariant _SteamRibbonPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.opacity != opacity;
  }
}

class _CoffeeCupPainter extends CustomPainter {
  const _CoffeeCupPainter({
    required this.porcelainTint,
    required this.liquidProgress,
    required this.exitProgress,
  });

  final double porcelainTint;
  final double liquidProgress;
  final double exitProgress;

  @override
  void paint(Canvas canvas, Size size) {
    final cupLeft = size.width * 0.22;
    final cupTop = size.height * 0.34;
    final cupRight = size.width * 0.76;
    final cupBottom = size.height * 0.78;
    final cupWidth = cupRight - cupLeft;
    final cupHeight = cupBottom - cupTop;
    final rimRect = Rect.fromCenter(
      center: Offset(size.width * 0.49, cupTop + 6),
      width: cupWidth * 0.98,
      height: 26,
    );
    final coffeeRect = Rect.fromCenter(
      center: Offset(size.width * 0.49, cupTop + 8),
      width: cupWidth * 0.84,
      height: 18,
    );
    final rippleRect = Rect.fromCenter(
      center: coffeeRect.center.translate(0, 1),
      width: coffeeRect.width * 0.9,
      height: coffeeRect.height * 0.82,
    );
    final saucerRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.86),
      width: size.width * 0.78,
      height: 24,
    );

    final shadowPaint = Paint()
      ..color = const Color(0xFF2A1B13).withValues(alpha: 0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.93),
        width: size.width * 0.7,
        height: 18,
      ),
      shadowPaint,
    );

    final saucerShadow = Paint()
      ..color = const Color(0xFF69544B).withValues(alpha: 0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawOval(saucerRect.shift(const Offset(0, 8)), saucerShadow);

    final saucerPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.lerp(const Color(0xFFF7F0EB), Colors.white, porcelainTint)!,
          const Color(0xFFE1D5CB),
        ],
      ).createShader(saucerRect);
    canvas.drawOval(saucerRect, saucerPaint);

    final saucerInner = Paint()..color = Colors.white.withValues(alpha: 0.52);
    canvas.drawOval(
      Rect.fromCenter(
        center: saucerRect.center.translate(0, -2),
        width: saucerRect.width * 0.82,
        height: saucerRect.height * 0.46,
      ),
      saucerInner,
    );

    final cupPath = Path()
      ..moveTo(cupLeft + 14, cupTop + 12)
      ..quadraticBezierTo(
        cupLeft + 8,
        cupTop + cupHeight * 0.45,
        cupLeft + 22,
        cupBottom - 4,
      )
      ..quadraticBezierTo(
        size.width * 0.49,
        cupBottom + 10,
        cupRight - 18,
        cupBottom - 2,
      )
      ..quadraticBezierTo(
        cupRight + 4,
        cupTop + cupHeight * 0.45,
        cupRight - 12,
        cupTop + 10,
      )
      ..close();

    final cupShadow = Paint()
      ..color = const Color(0xFF3A2921).withValues(alpha: 0.16)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);
    canvas.drawPath(cupPath.shift(const Offset(0, 10)), cupShadow);

    final cupPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.lerp(const Color(0xFFFDF9F5), Colors.white, porcelainTint)!,
          const Color(0xFFE9DED4),
          const Color(0xFFD4C2B7),
        ],
        stops: const [0.0, 0.58, 1.0],
      ).createShader(Rect.fromLTRB(cupLeft, cupTop, cupRight, cupBottom));
    canvas.drawPath(cupPath, cupPaint);

    final cupHighlight = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.7),
          Colors.white.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromLTRB(cupLeft, cupTop, cupRight, cupBottom));
    canvas.drawPath(
      Path()..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            cupLeft + 18,
            cupTop + 18,
            cupWidth * 0.2,
            cupHeight * 0.56,
          ),
          const Radius.circular(30),
        ),
      ),
      cupHighlight,
    );

    final rimPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.white.withValues(alpha: 0.92), const Color(0xFFE5D6CB)],
      ).createShader(rimRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawOval(rimRect, rimPaint);

    final liquidPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Color(0xFF4E321E), Color(0xFF2E1A10)],
      ).createShader(coffeeRect);
    canvas.drawOval(coffeeRect, liquidPaint);

    final liquidGlow = Paint()
      ..color = const Color(0xFF8F674D).withValues(alpha: 0.18);
    canvas.drawOval(
      Rect.fromCenter(
        center: coffeeRect.center.translate(-10, -2),
        width: coffeeRect.width * 0.28,
        height: coffeeRect.height * 0.38,
      ),
      liquidGlow,
    );

    final rippleWave = (math.sin(liquidProgress * math.pi * 2) + 1) / 2;
    final rippleWaveSecondary =
        (math.sin(liquidProgress * math.pi * 2 + 1.4) + 1) / 2;
    final ripplePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.white.withValues(
        alpha: 0.12 + (rippleWave * 0.1) + (exitProgress * 0.06),
      );
    final ripplePaintSecondary = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(
        0xFFD6B69D,
      ).withValues(alpha: 0.08 + (rippleWaveSecondary * 0.06));
    canvas.drawOval(
      Rect.fromCenter(
        center: rippleRect.center.translate(
          math.sin(liquidProgress * math.pi * 2) * 1.2,
          0.3,
        ),
        width: rippleRect.width * (0.84 + (rippleWave * 0.035)),
        height: rippleRect.height * (0.58 + (rippleWave * 0.04)),
      ),
      ripplePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: rippleRect.center.translate(
          -math.sin(liquidProgress * math.pi * 2 + 0.8) * 1.4,
          -0.1,
        ),
        width: rippleRect.width * (0.68 + (rippleWaveSecondary * 0.04)),
        height: rippleRect.height * (0.42 + (rippleWaveSecondary * 0.03)),
      ),
      ripplePaintSecondary,
    );

    final handlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.lerp(const Color(0xFFF8F2EC), Colors.white, porcelainTint)!,
          const Color(0xFFD8C7BC),
        ],
      ).createShader(Rect.fromLTWH(cupRight - 8, cupTop + 10, 58, 72));
    canvas.drawArc(
      Rect.fromLTWH(cupRight - 2, cupTop + 12, 50, 66),
      -1.1,
      3.7,
      false,
      handlePaint,
    );

    final innerHandlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withValues(alpha: 0.4);
    canvas.drawArc(
      Rect.fromLTWH(cupRight + 6, cupTop + 20, 34, 48),
      -1.0,
      3.5,
      false,
      innerHandlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CoffeeCupPainter oldDelegate) {
    return oldDelegate.porcelainTint != porcelainTint ||
        oldDelegate.liquidProgress != liquidProgress ||
        oldDelegate.exitProgress != exitProgress;
  }
}

class _BrandBlock extends StatelessWidget {
  const _BrandBlock({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Text(
            'Pavilijon',
            textAlign: TextAlign.center,
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: 60,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'THE SILENT CEREMONY',
            textAlign: TextAlign.center,
            style: theme.textTheme.labelLarge?.copyWith(
              fontSize: 10,
              color: const Color(0xFF5A6061).withValues(alpha: 0.62),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingSection extends StatelessWidget {
  const _LoadingSection({
    required this.controller,
    required this.theme,
    required this.exitProgress,
  });

  final Animation<double> controller;
  final ThemeData theme;
  final double exitProgress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final spacing = 6 + (exitProgress * 2);
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final phase = (controller.value - index * 0.16) % 1.0;
                final eased = Curves.easeInOut.transform(
                  1 - (phase - 0.5).abs() * 2,
                );
                final opacity = (0.28 + (eased * 0.72) - (exitProgress * 0.12))
                    .clamp(0.0, 1.0);
                final scale = 0.92 + (eased * 0.2) + (exitProgress * 0.08);

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: spacing),
                  child: Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(
                          0xFF815534,
                        ).withValues(alpha: opacity),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
        SizedBox(height: 28 - (exitProgress * 6)),
        Container(
          width: 48 + (exitProgress * 10),
          height: 1,
          color: const Color(0xFFADB3B4).withValues(alpha: 0.24),
        ),
      ],
    );
  }
}

class InitialSetupPage extends StatelessWidget {
  const InitialSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Konfigurasi Awal Diperlukan',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF2D3435),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'App mendeteksi ada konfigurasi yang belum lengkap. Arahkan user ke flow setup di halaman ini.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF5A6061),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
