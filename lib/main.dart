import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/splash_screen.dart';

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
