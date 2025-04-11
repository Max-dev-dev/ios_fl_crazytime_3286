import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsCubit extends Cubit<List<QuestionModel>> {
  QuestionsCubit() : super([]);

  Future<void> loadQuestionsFromJson() async {
    final String jsonString = await rootBundle.loadString(
      'assets/questions.json',
    );
    final List<dynamic> jsonData = json.decode(jsonString);

    final questions =
        jsonData.map((item) => QuestionModel.fromJson(item)).toList();

    emit(questions);
  }

  void toggleFavorite(QuestionModel question) {
    final index = state.indexWhere((q) => q.question == question.question);
    if (index == -1) return;

    final updated = state[index].copyWith(isFavorite: !state[index].isFavorite);

    final newState = [...state];
    newState[index] = updated;
    emit(newState);
  }

  List<QuestionModel> get favoriteQuestions =>
      state.where((q) => q.isFavorite).toList();
}

class QuestionOption {
  final String text;
  final bool isCorrect;

  QuestionOption({required this.text, required this.isCorrect});

  factory QuestionOption.fromJson(Map<String, dynamic> json) {
    return QuestionOption(text: json['text'], isCorrect: json['isCorrect']);
  }

  Map<String, dynamic> toJson() => {'text': text, 'isCorrect': isCorrect};
}

class QuestionModel {
  final String question;
  final List<QuestionOption> options;
  final bool isFavorite;

  QuestionModel({
    required this.question,
    required this.options,
    this.isFavorite = false,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      options:
          (json['options'] as List)
              .map((e) => QuestionOption.fromJson(e))
              .toList(),
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'question': question,
    'options': options.map((e) => e.toJson()).toList(),
    'isFavorite': isFavorite,
  };

  QuestionModel copyWith({bool? isFavorite}) {
    return QuestionModel(
      question: question,
      options: options,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
