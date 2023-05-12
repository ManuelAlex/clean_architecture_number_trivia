import 'package:number_trivia/features/number_trivia/presentation/riverpod/number_trivia_state/number_trivia_result.dart';

abstract class Usecase<Type, Params> {
  Future<NumberTrivaReturnResult> call({
    required Params params,
  });
}
