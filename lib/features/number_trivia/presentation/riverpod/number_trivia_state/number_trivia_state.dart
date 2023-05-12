import 'package:flutter/foundation.dart' show immutable;
import 'package:number_trivia/features/number_trivia/presentation/riverpod/number_trivia_state/number_trivia_result.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

@immutable
class NumberTriviaState {
  final NumberTriviaResult? result;
  final NumberTrivia? numberTrivia;

  final bool isLoading;
  final String? erroMessage;
  const NumberTriviaState({
    required this.numberTrivia,
    required this.result,
    this.erroMessage,
    required this.isLoading,
  });
  const NumberTriviaState.empty()
      : isLoading = false,
        numberTrivia = null,
        erroMessage = null,
        result = null;

  const NumberTriviaState.loading()
      : isLoading = true,
        erroMessage = null,
        numberTrivia = null,
        result = null;

  NumberTriviaState copyWIthIsloading(
    bool isLoading,
  ) =>
      NumberTriviaState(
        numberTrivia: numberTrivia,
        result: result,
        isLoading: isLoading,
      );

  NumberTriviaState copyWIthNumberTriviaStateFailure({
    required NumberTrivia numberTrivia,
  }) =>
      NumberTriviaState(
        numberTrivia: numberTrivia,
        result: result,
        isLoading: false,
      );

  @override
  bool operator ==(covariant NumberTriviaState other) =>
      runtimeType == other.runtimeType &&
      result == other.result &&
      numberTrivia == other.numberTrivia &&
      isLoading == other.isLoading;

  @override
  int get hashCode => Object.hashAll(
        [
          runtimeType,
          result,
          numberTrivia,
          isLoading,
        ],
      );
}
