import 'package:flutter_bloc/flutter_bloc.dart';

class DecisionWheel {
  final String name;
  final String question;
  final List<String> options;

  DecisionWheel({
    required this.name,
    required this.question,
    required this.options,
  });
}

class WheelCubit extends Cubit<List<DecisionWheel>> {
  WheelCubit() : super([]);

  void addWheel(DecisionWheel wheel) {
    emit([...state, wheel]);
  }

  void deleteWheel(int index) {
    final updated = [...state]..removeAt(index);
    emit(updated);
  }
}

