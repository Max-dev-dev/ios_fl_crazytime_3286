import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/cubit/my_question_cubit/my_question_cubit.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/cubit/questions/questions_cubit.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/cubit/wheel_cubit/wheel_cubit.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/pages/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CustomQuestionsCubit()),
        BlocProvider(create: (context) => QuestionsCubit()),
        BlocProvider(create: (context) => WheelCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/main_background.png',
                  fit: BoxFit.cover,
                ),
              ),
              child ?? const SizedBox.shrink(),
            ],
          );
        },
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
          scaffoldBackgroundColor: Colors.transparent,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
