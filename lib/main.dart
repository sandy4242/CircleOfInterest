import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/main_screen.dart';

void main() {
  runApp(const CircleOfInterest());
}

class CircleOfInterest extends StatefulWidget {
  const CircleOfInterest({super.key});

  @override
  State<CircleOfInterest> createState() => _CircleOfInterestState();
}

class _CircleOfInterestState extends State<CircleOfInterest> {
  ThemeMode _themeMode = ThemeMode.system; // Default to system theme

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CircleOfInterest',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark, // Make sure you define dark theme in app_theme.dart
      themeMode: _themeMode,
      home: MainScreen(
        onToggleTheme: toggleTheme, // Pass toggle function to MainScreen
      ),
    );
  }
}

