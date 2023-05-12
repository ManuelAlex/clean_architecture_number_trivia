import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/number_trivia_state/number_trivia_result.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/providers/number_trivia_provider.dart';

final providerWithTrivia = Provider((ref) {
  final trivia = ref.watch(numberTriviaStateProvider).numberTrivia;
  final triviaResult = ref.watch(numberTriviaStateProvider).result;
  final triviaSuccessResult = triviaResult == NumberTriviaResult.success;
  if (triviaSuccessResult) {
    return trivia;
  }
  return null;
});
