import 'package:number_trivia/features/number_trivia/presentation/riverpod/number_trivia_state/number_trivia_result.dart';
import 'package:number_trivia/core/usecases/usecases.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTriviaUsecase implements Usecase<NumberTrivia, Params> {
  final NumberTriaviaRepository repository;
  const GetConcreteNumberTriviaUsecase({
    required this.repository,
  });

  @override
  Future<NumberTrivaReturnResult> call({
    required Params params,
  }) async {
    final result = await repository.getConcreteNumberTriavia(
      params: params.number,
    );
    print(result.numberTrivia!.triviaText + 'usecase Get concrete');
    //print(result.numberTrivia!.triviaNumber);
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

class Params {
  final int number;
  const Params({
    required this.number,
  });

  @override
  bool operator ==(covariant Params other) => number == other.number;

  @override
  int get hashCode => number.hashCode;
}
