import 'package:flutter/material.dart';

class SplashAnimations {
  final AnimationController controller;
  late final Animation<double> fadeAnimation;
  late final Animation<double> scaleAnimation;

  SplashAnimations(this.controller) {
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeIn),
      ),
    );

    scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
      ),
    );
  }

  void start() {
    controller.forward();
  }

  void dispose() {
    controller.dispose();
  }
}