import 'package:number_trivia/features/number_trivia/presentation/riverpod/number_trivia_state/number_trivia_result.dart';
import 'package:number_trivia/core/usecases/no_params.dart';
import 'package:number_trivia/core/usecases/usecases.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTriviaUsecase implements Usecase<NumberTrivia, NoParams> {
  final NumberTriaviaRepository repository;
  const GetRandomNumberTriviaUsecase({
    required this.repository,
  });

  @override
  Future<NumberTrivaReturnResult> call({
    NoParams? params,
  }) async {
    try {
      final result = await repository.getRandomNumberTriavia();
      return NumberTrivaReturnResult(
          numberTrivia: result.numberTrivia,
          result: NumberTriviaResult.success);
    } catch (_) {
      return const NumberTrivaReturnResult(
        numberTrivia: null,
        result: NumberTriviaResult.serverFailures,
      );
    }
  }
}
