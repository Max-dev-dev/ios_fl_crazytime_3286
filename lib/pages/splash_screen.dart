import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/pages/main_screen.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/pages/onboarding.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/services/audio_service.dart';

class FirstRunService {
  static final FirstRunService _instance = FirstRunService._internal();

  bool _firstRun = true;

  factory FirstRunService() => _instance;

  FirstRunService._internal();

  bool get isFirstRun => _firstRun;

  void markAsCompleted() {
    _firstRun = false;
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AudioManager().init();
    _handleNavigation();
  }

  void _handleNavigation() {
    final isFirstRun = FirstRunService().isFirstRun;

    if (isFirstRun) {
      FirstRunService().markAsCompleted();
    }

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => isFirstRun ? OnboardingScreen() : const MainScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/splash_background.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
