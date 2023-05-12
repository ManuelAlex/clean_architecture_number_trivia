import 'package:number_trivia/features/number_trivia/presentation/riverpod/number_trivia_state/number_trivia_result.dart';

abstract class NumberTriaviaRepository {
  Future<NumberTrivaReturnResult> getConcreteNumberTriavia({
    required int params,
  });
  Future<NumberTrivaReturnResult> getRandomNumberTriavia();
}
