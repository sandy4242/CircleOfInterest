import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'splash_animations.dart';
import '../../constants/splash_constants.dart';
import '../../core/theme/app_colors.dart';  

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final SplashAnimations _animations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: SplashConstants.animationDurationMs),
      vsync: this,
    );
    _animations = SplashAnimations(_animationController);
    _animations.start();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(Duration(seconds: SplashConstants.splashDelaySeconds));
    if (mounted && context.mounted) {
      context.go(SplashConstants.loginRoute);
    }
  }

  @override
  void dispose() {
    _animations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.accent],
          ),
        ),
        child: Stack(
          children: [
            _buildBackgroundCircle(
              top: -100,
              right: -100,
              size: 300,
              opacity: 0.1,
            ),
            _buildBackgroundCircle(
              bottom: -50,
              left: -50,
              size: 200,
              opacity: 0.05,
              scale: 0.8,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  const SizedBox(height: 40),
                  _buildLoadingIndicator(),
                ],
              ),
            ),
            _buildBottomText(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundCircle({
    double? top,
    double? right,
    double? bottom,
    double? left,
    required double size,
    required double opacity,
    double scale = 1.0,
  }) {
    return Positioned(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _animations.fadeAnimation.value * opacity,
            child: Transform.scale(
              scale: _animations.scaleAnimation.value * scale,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _animations.scaleAnimation.value,
          child: FadeTransition(
            opacity: _animations.fadeAnimation,
            child: Container(
              padding: EdgeInsets.all(SplashConstants.logoPadding),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Image.asset(
                SplashConstants.logoAssetPath,
                height: SplashConstants.logoSize,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _animations.fadeAnimation,
          child: Column(
            children: [
              SizedBox(
                width: SplashConstants.loadingIndicatorSize,
                height: SplashConstants.loadingIndicatorSize,
                child: CircularProgressIndicator(
                  strokeWidth: SplashConstants.loadingIndicatorStrokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                SplashConstants.loadingText,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomText() {
    return Positioned(
      bottom: 50,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _animations.fadeAnimation,
            child: Text(
              SplashConstants.welcomeText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14,
                fontWeight: FontWeight.w300,
                letterSpacing: 2.0,
              ),
            ),
          );
        },
      ),
    );
  }
    }