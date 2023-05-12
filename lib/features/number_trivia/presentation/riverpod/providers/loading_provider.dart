import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/providers/number_trivia_provider.dart';

final loadingProvider = Provider<bool>((ref) {
  final result = ref.watch(numberTriviaStateProvider);
  return result.isLoading;
});
