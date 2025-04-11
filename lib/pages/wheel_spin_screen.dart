import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/cubit/wheel_cubit/wheel_cubit.dart';

class WheelSpinScreen extends StatefulWidget {
  final DecisionWheel wheel;

  const WheelSpinScreen({super.key, required this.wheel});

  @override
  State<WheelSpinScreen> createState() => _WheelSpinScreenState();
}

class _WheelSpinScreenState extends State<WheelSpinScreen> {
  final StreamController<int> _controller = StreamController<int>();
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    _spin();
  }

  void _spin() {
    setState(() {
      selectedIndex = null;
    });

    final index = Random().nextInt(widget.wheel.options.length);
    _controller.add(index);

    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        selectedIndex = index;
      });
    });
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final background = const AssetImage("assets/images/wheel_background.png");
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(
              color: Colors.white.withOpacity(0.5),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            Text(
              'Back',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(height: screenWidth > 375 ? 100 : 40),
          Text(
            widget.wheel.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: screenWidth > 375 ? 400 : 300,
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFF1B016),
                    Color(0xFFFFE898),
                    Color(0xFFDE7519),
                  ],
                ),
              ),
              child: FortuneWheel(
                selected: _controller.stream,
                onAnimationEnd: () {
                  setState(() {});
                },
                items: [
                  for (int i = 0; i < widget.wheel.options.length; i++)
                    FortuneItem(
                      child: Text(
                        widget.wheel.options[i],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      style: FortuneItemStyle(
                        color:
                            i % 2 == 0
                                ? const Color(0xFFF1B016)
                                : const Color(0xFF881500),
                        borderColor: const Color(0xFF761520),
                        borderWidth: 4,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (selectedIndex != null)
            Text(
              widget.wheel.options[selectedIndex!],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontStyle: FontStyle.italic,
              ),
            ),
          Spacer(),
          GestureDetector(
            onTap: _spin,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              margin: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
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
              child: const Center(
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
