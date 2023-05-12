import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/notifier/number_trivia_notifier.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/number_trivia_state/number_trivia_state.dart';
import 'package:number_trivia/injection_container.dart';

final numberTriviaStateProvider =
    StateNotifierProvider<NumberTriviStateNotifier, NumberTriviaState>(
  (ref) => sl<NumberTriviStateNotifier>(),
);
