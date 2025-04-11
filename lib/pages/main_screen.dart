import 'package:flutter/material.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/pages/game_screen.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/pages/my_questions_screen.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/pages/settings_screen.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/pages/wheel_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/main_screen_background.png',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Spacer(),
                  const SizedBox(height: 30),
                  _buildMenuButton(
                    'Friends & Choices',
                    '🤹',
                    screenWidth > 375 ? 100 : 80,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GameScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuButton(
                    'The Decision Wheel',
                    '🔮',
                    screenWidth > 375 ? 100 : 80,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WheelScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuButton(
                    'Create Your Show',
                    '✍️',
                    screenWidth > 375 ? 100 : 80,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyQuestionsScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuButton(
                    'The Ringmaster\'s Tent',
                    '🎩',
                    screenWidth > 375 ? 100 : 80,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: screenWidth > 375 ? 30 : 5),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuButton(
    String title,
    String emoji,
    double height,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF761520),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Color(0xFFF1B016), width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(emoji, style: const TextStyle(fontSize: 40)),
          ],
        ),
      ),
    );
  }
}
