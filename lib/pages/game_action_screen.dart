// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/app.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/cubit/questions/questions_cubit.dart';
import 'package:share_plus/share_plus.dart';

class GameActionScreen extends StatefulWidget {
  const GameActionScreen({super.key});

  @override
  State<GameActionScreen> createState() => _GameActionScreenState();
}

class _GameActionScreenState extends State<GameActionScreen> {
  int currentIndex = 0;
  bool isAnswered = false;
  int? selectedOptionIndex;

  Future<bool> _onWillPop() async {
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (_) => _backConfirmationDialog(),
    );
    return shouldLeave ?? false;
  }

  AlertDialog _backConfirmationDialog() {
    return AlertDialog(
      backgroundColor: const Color(0xFF8D1527),
      title: const Text(
        'Leaving the Show Already?',
        style: TextStyle(color: Colors.white),
      ),
      content: const Text(
        "The spotlight's still on you, star of the stage! Are you sure you want to exit and miss the next act of fabulous fun?",
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text(
            'Exit Anyway',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(
            'Stay on Stage',
            style: TextStyle(color: Color(0xFFF1B016), fontSize: 18.0),
          ),
        ),
      ],
    );
  }

  void _nextQuestion(List<QuestionModel> questions) {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        isAnswered = false;
        selectedOptionIndex = null;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              BackButton(
                color: Colors.white.withOpacity(0.5),
                onPressed: () async {
                  final shouldExit = await _onWillPop();
                  if (shouldExit) Navigator.pop(context);
                },
              ),
              Text(
                'Back',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed:
                    () => _nextQuestion(context.read<QuestionsCubit>().state),
                child: Text(
                  'Skip Question',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontStyle: FontStyle.italic,
                    color:  Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: BlocBuilder<QuestionsCubit, List<QuestionModel>>(
            builder: (context, questions) {
              if (questions.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              final question = questions[currentIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 280,

                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFF1B016),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 24,
                    ),
                    child: Column(
                      children: [
                        Text(
                          question.question,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        const SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await Share.share(
                                  'Check this out: "${question.question}" — what would you choose? 🧐✨',
                                );
                              },
                              icon: Image.asset(
                                'assets/images/share_icon.png',
                                width: 56,
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                context.read<QuestionsCubit>().toggleFavorite(
                                  question,
                                );
                              },
                              icon: Image.asset(
                                question.isFavorite
                                    ? 'assets/images/favourite_icon_on.png'
                                    : 'assets/images/favourite_icon.png',
                                width: 56,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  ...List.generate(question.options.length, (i) {
                    final option = question.options[i];
                    final isSelected = selectedOptionIndex == i;
                    final isCorrect = option.isCorrect;

                    Color borderColor = const Color(0xFFF1B016);
                    if (isAnswered && isSelected && isCorrect) {
                      borderColor = Colors.yellow;
                    }

                    return GestureDetector(
                      onTap:
                          isAnswered
                              ? null
                              : () {
                                setState(() {
                                  selectedOptionIndex = i;
                                  isAnswered = true;
                                });
                                Timer(
                                  const Duration(seconds: 2),
                                  () => _nextQuestion(questions),
                                );
                              },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6.0),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF761520),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: borderColor, width: 4),
                        ),
                        child: Text(
                          option.text,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 40),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
