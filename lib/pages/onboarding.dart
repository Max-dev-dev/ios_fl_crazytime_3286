import 'package:flutter/material.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/pages/main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  final List<String> _imagePaths = [
    'assets/images/onboarding_images/1.png',
    'assets/images/onboarding_images/2.png',
    'assets/images/onboarding_images/3.png',
  ];

  final List<String> _buttonTexts = [
    "Let the Show Begin",
    "Sounds Fun!",
    "I'm In!",
  ];

  void _nextPage() {
    if (_currentIndex < _imagePaths.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(_imagePaths[_currentIndex], fit: BoxFit.cover),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: _nextPage,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFF1B016),
                      Color(0xFFFFE898),
                      Color(0xFFDE7519),
                      Color(0xFFDE7519),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    _buttonTexts[_currentIndex],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
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
