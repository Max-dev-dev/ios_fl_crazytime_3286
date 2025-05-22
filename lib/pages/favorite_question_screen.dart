import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/app.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/cubit/questions/questions_cubit.dart';
import 'package:share_plus/share_plus.dart';

class FavoriteQuestionScreen extends StatelessWidget {
  const FavoriteQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(
              color: Colors.white.withOpacity(0.5),
              onPressed: () => Navigator.pop(context),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: BlocBuilder<QuestionsCubit, List<QuestionModel>>(
          builder: (context, questions) {
            final favorites = questions.where((q) => q.isFavorite).toList();

            if (favorites.isEmpty) {
              return const Center(
                child: Text(
                  'No favorite questions yet.',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: List.generate(favorites.length, (index) {
                  final q = favorites[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF761520),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFF1B016),
                        width: 3,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            q.question,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await Share.share(
                                  'Hey! Check this question out: "${q.question}" — what would YOU choose?',
                                );
                              },
                              icon: Image.asset(
                                'assets/images/share_icon.png',
                                width: 40,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<QuestionsCubit>().toggleFavorite(
                                  q,
                                );
                              },
                              icon: Image.asset(
                                q.isFavorite
                                    ? 'assets/images/favourite_icon_on.png'
                                    : 'assets/images/favourite_icon.png',
                                width: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
