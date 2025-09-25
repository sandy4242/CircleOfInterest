import 'package:circle_of_interest/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const CircleOfInterest());
}

class CircleOfInterest extends StatelessWidget {
  const CircleOfInterest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CircleOfInterest',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainScreen(),
    );
  }
}
