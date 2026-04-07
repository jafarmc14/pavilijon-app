import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const PavilijonApp());
}

class PavilijonApp extends StatelessWidget {
  const PavilijonApp({super.key});

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFFF9F9F9);
    const surface = Color(0xFFF9F9F9);
    const onSurface = Color(0xFF2D3435);
    const onSurfaceVariant = Color(0xFF5A6061);
    const secondary = Color(0xFF815534);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pavilijon',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: secondary,
          surface: surface,
          onSurface: onSurface,
        ),
        scaffoldBackgroundColor: background,
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 58,
            height: 0.95,
            fontWeight: FontWeight.w900,
            letterSpacing: -2.5,
            color: onSurface,
          ),
          labelLarge: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 4.4,
            color: onSurfaceVariant,
          ),
          bodyMedium: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.8,
            color: onSurfaceVariant,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static const _minimumSplashDuration = Duration(seconds: 3);

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

    await _prepareInitialData();
    final isConfigurationValid = await _checkInitialConfiguration();

    final remainingDuration = _minimumSplashDuration - stopwatch.elapsed;
    if (remainingDuration > Duration.zero) {
      await Future.delayed(remainingDuration);
    }

    await _playExitTransition();

    if (!mounted) return;

    final nextPage = isConfigurationValid
        ? const HomePage()
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

  Future<void> _prepareInitialData() async {
    _setStatusLabel('LOADING INITIAL DATA...');
    await Future.delayed(const Duration(milliseconds: 1400));
  }

  Future<bool> _checkInitialConfiguration() async {
    _setStatusLabel('CHECKING INITIAL CONFIGURATION...');
    await Future.delayed(const Duration(milliseconds: 900));

    // Replace this with the real startup validation once the config source exists.
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

    final rippleWave = ((math.sin(liquidProgress * math.pi * 2) + 1) / 2);
    final rippleWaveSecondary =
        ((math.sin(liquidProgress * math.pi * 2 + 1.4) + 1) / 2);
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final featuredBrews = [
      const _FeaturedBrewData(
        title: 'Onyx Cold Brew',
        description: 'Notes of dark chocolate and smoke',
        price: '\$7.50',
        icon: Icons.dark_mode_outlined,
        palette: [Color(0xFF30211A), Color(0xFF6D4C39)],
      ),
      const _FeaturedBrewData(
        title: 'Kyoto Matcha Ritual',
        description: 'Stone-ground, ceremonial grade',
        price: '\$9.00',
        icon: Icons.spa_outlined,
        palette: [Color(0xFF4C6B3C), Color(0xFF8EA86A)],
      ),
      const _FeaturedBrewData(
        title: 'Cloud Foam Latte',
        description: 'Oat milk, vanilla bean infusion',
        price: '\$6.50',
        icon: Icons.cloud_outlined,
        palette: [Color(0xFF786555), Color(0xFFD8C4AF)],
      ),
    ];

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
                  _HeaderIconButton(icon: Icons.menu_rounded),
                  const SizedBox(width: 12),
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
                  const SizedBox(width: 12),
                  _HeaderIconButton(icon: Icons.search_rounded),
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
                  const _HeroBanner(),
                  const SizedBox(height: 44),
                  const _SectionHeading(
                    eyebrow: 'Featured Brews',
                    title: 'The Signature Collection',
                    actionLabel: 'View All',
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 392,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredBrews.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 20),
                      itemBuilder: (context, index) {
                        return _FeaturedBrewCard(data: featuredBrews[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 52),
                  const _StorySection(),
                  const SizedBox(height: 40),
                  const _LoyaltyBanner(),
                  const SizedBox(height: 40),
                  const _LocationSection(),
                  const SizedBox(height: 40),
                  _TermsEntryCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const TermsConditionsPage(),
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
      bottomNavigationBar: const _HomeBottomNavBar(),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap ?? () {},
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, color: const Color(0xFF111315)),
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.88,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const _AmbientPhotoPanel(
              palette: [
                Color(0xFF2A201C),
                Color(0xFF6B5548),
                Color(0xFFD9CEC2),
              ],
              icon: Icons.local_cafe_rounded,
              iconSize: 94,
              alignment: Alignment(0.65, -0.18),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.08),
                      Colors.black.withValues(alpha: 0.62),
                    ],
                    stops: const [0.2, 0.52, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 28,
              right: 28,
              bottom: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The Morning Ritual',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.86),
                      fontSize: 11,
                      letterSpacing: 2.6,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Purity in\nEvery Drop.',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      height: 0.94,
                      letterSpacing: -1.6,
                    ),
                  ),
                  const SizedBox(height: 22),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF815534),
                      foregroundColor: const Color(0xFFFFF7F4),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 16,
                      ),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'EXPLORE BEANS',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: const Color(0xFFFFF7F4),
                        fontSize: 10,
                        letterSpacing: 2.4,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 22,
              bottom: 24,
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(width: 6),
                  for (var i = 0; i < 2; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Container(
                        width: 10,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.32),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.eyebrow,
    required this.title,
    required this.actionLabel,
  });

  final String eyebrow;
  final String title;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eyebrow.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFF815534),
                  fontSize: 10,
                  letterSpacing: 2.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.8,
                  color: const Color(0xFF17191A),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF2D3435),
            padding: EdgeInsets.zero,
          ),
          child: Text(
            actionLabel.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 10,
              letterSpacing: 1.8,
              decoration: TextDecoration.underline,
              decorationColor: const Color(0xFFADB3B4),
            ),
          ),
        ),
      ],
    );
  }
}

class _FeaturedBrewCard extends StatelessWidget {
  const _FeaturedBrewCard({required this.data});

  final _FeaturedBrewData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 274,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _AmbientPhotoPanel(
                    palette: data.palette,
                    icon: data.icon,
                    iconSize: 82,
                    alignment: const Alignment(0.65, -0.08),
                  ),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          color: Colors.white.withValues(alpha: 0.82),
                          child: Text(
                            data.price,
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF1F2324),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            data.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF17191A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13,
              color: const Color(0xFF5A6061),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _StorySection extends StatelessWidget {
  const _StorySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F4),
        borderRadius: BorderRadius.circular(28),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          final textContent = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OUR STORY',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFF815534),
                  fontSize: 10,
                  letterSpacing: 2.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Born in the backstreets of Omotesando.',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.02,
                  letterSpacing: -0.8,
                  color: const Color(0xFF17191A),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'We believe coffee is more than caffeine. It is a pause. A moment of clarity in a crowded world. Our beans are sourced with precision and roasted in small batches to preserve the silent ceremony of the brew.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF5A6061),
                  height: 1.65,
                ),
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF17191A),
                  padding: EdgeInsets.zero,
                ),
                iconAlignment: IconAlignment.end,
                icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                label: Text(
                  'READ THE MANIFESTO',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 10,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          );
          const image = AspectRatio(
            aspectRatio: 0.96,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              child: _AmbientPhotoPanel(
                palette: [
                  Color(0xFF47403A),
                  Color(0xFF74675C),
                  Color(0xFFC8B9A9),
                ],
                icon: Icons.coffee_maker_outlined,
                iconSize: 92,
                alignment: Alignment(0.6, -0.08),
              ),
            ),
          );

          if (isWide) {
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: textContent,
                  ),
                ),
                const Expanded(child: image),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [textContent, const SizedBox(height: 24), image],
          );
        },
      ),
    );
  }
}

class _LoyaltyBanner extends StatelessWidget {
  const _LoyaltyBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Join our Ritual',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: const Color(0xFF17191A),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Earn celestial points for every cup and unlock exclusive early access to seasonal micro-lots.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF5A6061),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 22),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF111315),
              foregroundColor: const Color(0xFFF9F9F9),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              shape: const StadiumBorder(),
            ),
            child: Text(
              'BECOME A MEMBER',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFFF9F9F9),
                fontSize: 11,
                letterSpacing: 2.2,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationSection extends StatelessWidget {
  const _LocationSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 720;
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
              'Shibuya, Tokyo',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF17191A),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '4-26-14 Jingumae\nShibuya-ku, Tokyo 150-0001\nJapan',
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
                  decoration: const BoxDecoration(
                    color: Color(0xFF2FB45A),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Currently Open',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 13,
                    letterSpacing: 0,
                    color: const Color(0xFF17191A),
                  ),
                ),
              ],
            ),
          ],
        );

        const map = ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(28)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _AmbientPhotoPanel(
                palette: [
                  Color(0xFFD7D3CE),
                  Color(0xFFB9B3AB),
                  Color(0xFFF1ECE6),
                ],
                icon: Icons.map_outlined,
                iconSize: 84,
                alignment: Alignment(0.55, -0.18),
              ),
            ],
          ),
        );

        final mapWithPin = Stack(
          fit: StackFit.expand,
          children: [
            map,
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.06),
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
          ],
        );

        if (isWide) {
          return SizedBox(
            height: 270,
            child: Row(
              children: [
                Expanded(child: details),
                const SizedBox(width: 24),
                Expanded(flex: 2, child: mapWithPin),
              ],
            ),
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

class _TermsEntryCard extends StatelessWidget {
  const _TermsEntryCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFADB3B4).withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DOCUMENTS',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: const Color(0xFF815534),
              fontSize: 10,
              letterSpacing: 2.2,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Terms & Conditions (Regulamin)',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -0.6,
              color: const Color(0xFF17191A),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Baca ketentuan penggunaan, aturan komunitas, dan standar layanan kami dalam satu halaman editorial.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF5A6061),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 22),
          OutlinedButton.icon(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF17191A),
              side: BorderSide(
                color: const Color(0xFFADB3B4).withValues(alpha: 0.45),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              shape: const StadiumBorder(),
            ),
            icon: const Icon(Icons.receipt_long_outlined, size: 20),
            label: Text(
              'OPEN TERMS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 10,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

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
      bottomNavigationBar: const _TermsBottomBar(),
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

class _TermsBottomBar extends StatelessWidget {
  const _TermsBottomBar();

  @override
  Widget build(BuildContext context) {
    final items = [
      const _NavItemData(label: 'Home', icon: Icons.home_rounded),
      const _NavItemData(label: 'Store', icon: Icons.local_cafe_outlined),
      const _NavItemData(label: 'Grab & Go', icon: Icons.shopping_bag_outlined),
      const _NavItemData(label: 'Track', icon: Icons.location_on_outlined),
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              color: const Color(0xFFF9F9F9).withValues(alpha: 0.84),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _BottomNavItem(
                    data: items[0],
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  _BottomNavItem(data: items[1]),
                  _BottomNavItem(data: items[2]),
                  _BottomNavItem(data: items[3]),
                ],
              ),
            ),
          ),
        ),
      ),
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

class _AmbientPhotoPanel extends StatelessWidget {
  const _AmbientPhotoPanel({
    required this.palette,
    required this.icon,
    required this.iconSize,
    required this.alignment,
  });

  final List<Color> palette;
  final IconData icon;
  final double iconSize;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: palette,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: -30,
            top: -30,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.12),
              ),
            ),
          ),
          Positioned(
            right: -22,
            bottom: -28,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned.fill(child: CustomPaint(painter: _AmbientLinePainter())),
          Align(
            alignment: alignment,
            child: Icon(
              icon,
              size: iconSize,
              color: Colors.white.withValues(alpha: 0.74),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmbientLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (var i = 0; i < 4; i++) {
      final path = Path()
        ..moveTo(size.width * (0.08 + i * 0.14), 0)
        ..quadraticBezierTo(
          size.width * (0.18 + i * 0.14),
          size.height * 0.42,
          size.width * (0.04 + i * 0.18),
          size.height,
        );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HomeBottomNavBar extends StatelessWidget {
  const _HomeBottomNavBar();

  @override
  Widget build(BuildContext context) {
    final items = [
      const _NavItemData(label: 'Home', icon: Icons.home_rounded, active: true),
      const _NavItemData(label: 'Store', icon: Icons.local_cafe_outlined),
      const _NavItemData(label: 'Grab & Go', icon: Icons.shopping_bag_outlined),
      const _NavItemData(label: 'Track', icon: Icons.location_on_outlined),
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(36),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.82),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 32,
                    offset: const Offset(0, -8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: items
                    .map((item) => _BottomNavItem(data: item))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({required this.data, this.onTap});

  final _NavItemData data;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final active = data.active;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: EdgeInsets.symmetric(
            horizontal: active ? 18 : 10,
            vertical: active ? 10 : 8,
          ),
          decoration: BoxDecoration(
            color: active ? const Color(0xFFF2F1EE) : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                data.icon,
                size: 22,
                color: active
                    ? const Color(0xFF17191A)
                    : const Color(0xFF9C9D9D),
              ),
              const SizedBox(height: 4),
              Text(
                data.label.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 9,
                  letterSpacing: 1.8,
                  fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                  color: active
                      ? const Color(0xFF17191A)
                      : const Color(0xFF9C9D9D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturedBrewData {
  const _FeaturedBrewData({
    required this.title,
    required this.description,
    required this.price,
    required this.icon,
    required this.palette,
  });

  final String title;
  final String description;
  final String price;
  final IconData icon;
  final List<Color> palette;
}

class _NavItemData {
  const _NavItemData({
    required this.label,
    required this.icon,
    this.active = false,
  });

  final String label;
  final IconData icon;
  final bool active;
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
