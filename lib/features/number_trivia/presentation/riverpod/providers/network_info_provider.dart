import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/number_trivia_state/number_trivia_result.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/providers/number_trivia_provider.dart';

final networkInfoProvider = Provider((ref) {
  final isConnected = ref.watch(numberTriviaStateProvider).networkFailure;
  final iResult = ref.watch(numberTriviaStateProvider).result;
  final iSuccessResult = iResult == NumberTriviaResult.isOffLine;
  return isConnected == true && iSuccessResult == true;
});
