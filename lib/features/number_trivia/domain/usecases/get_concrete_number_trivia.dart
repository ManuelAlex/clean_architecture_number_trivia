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
    try {
      final result = await repository.getConcreteNumberTriavia(
        params: params.number,
      );
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
