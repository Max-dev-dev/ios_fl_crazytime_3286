import 'package:flutter_bloc/flutter_bloc.dart';

class CustomQuestion {
  final String question;
  final String option1;
  final String option2;

  CustomQuestion({
    required this.question,
    required this.option1,
    required this.option2,
  });
}


class CustomQuestionsCubit extends Cubit<List<CustomQuestion>> {
  CustomQuestionsCubit() : super([]);

  void addQuestion(CustomQuestion question) {
    emit([...state, question]);
  }

  void deleteQuestion(int index) {
    final updatedList = [...state]..removeAt(index);
    emit(updatedList);
  }
}
