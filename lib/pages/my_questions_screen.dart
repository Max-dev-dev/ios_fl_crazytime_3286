import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/cubit/my_question_cubit/my_question_cubit.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/pages/create_question_screen.dart';

class MyQuestionsScreen extends StatelessWidget {
  const MyQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AlertDialog _deleteConfirmationDialog(int index) {
      return AlertDialog(
        backgroundColor: Color(0xFF8D1527),
        title: Text(
          'Delete This Question?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure? This bit of brilliance will vanish forever!',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Keep It',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<CustomQuestionsCubit>().deleteQuestion(index);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Color(0xFFF1B016), fontSize: 18.0),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        child: Column(
          children: [
            const Text(
              "My Custom Questions",
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 10.0),
            const Text(
              "Let your imagination run wild — craft the most ridiculous choices ever!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 60.0),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CreateQuestionScreen()),
                );

                if (result != null && result is CustomQuestion) {
                  context.read<CustomQuestionsCubit>().addQuestion(result);
                }
              },

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
                      Color(0xFFDE7519),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create New Question',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.add, color: Colors.white),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.0),
            const Text(
              "Created Questions",
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 24.0),
            Expanded(
              child: BlocBuilder<CustomQuestionsCubit, List<CustomQuestion>>(
                builder: (context, questions) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(questions.length, (index) {
                        final q = questions[index];
                        return Container(
                          height: 85,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF761520),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Color(0xFFF1B016),
                              width: 3,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  q.question,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog<bool>(
                                    context: context,
                                    builder: (_) => _deleteConfirmationDialog(index),
                                  );
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Color(0xFFF1B016),
                                ),
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
          ],
        ),
      ),
    );
  }
}
