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
    final result = await repository.getRandomNumberTriavia();
    print(result.numberTrivia!.triviaText + 'usecase GetRand');
    switch (result.result) {
      case NumberTriviaResult.success:
        return NumberTrivaReturnResult(
          numberTrivia: result.numberTrivia,
          result: NumberTriviaResult.success,
        );

      case NumberTriviaResult.isOffLine:
        return NumberTrivaReturnResult(
          numberTrivia: result.numberTrivia,
          result: NumberTriviaResult.isOffLine,
        );

      case NumberTriviaResult.serverFailures:
        return NumberTrivaReturnResult(
          numberTrivia: result.numberTrivia,
          result: NumberTriviaResult.serverFailures,
        );

      case NumberTriviaResult.cacheFailures:
        return NumberTrivaReturnResult(
          numberTrivia: result.numberTrivia,
          result: NumberTriviaResult.cacheFailures,
        );
      default:
        return NumberTrivaReturnResult(
          numberTrivia: result.numberTrivia,
          result: NumberTriviaResult.success,
        );
    }
  }
}
