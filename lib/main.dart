import 'package:circle_of_interest/presentation/screens/home_screen.dart';
import 'package:circle_of_interest/presentation/widget/bottom_nav.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        ),
      home: const MainBottomNavBar(),
    );
  }
}
