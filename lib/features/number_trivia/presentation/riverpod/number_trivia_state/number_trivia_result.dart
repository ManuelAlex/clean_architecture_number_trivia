import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

enum NumberTriviaResult {
  success,
  isOffLine,
  serverFailures,
  cacheFailures,
}

class NumberTrivaReturnResult {
  final NumberTriviaResult? result;
  final NumberTrivia? numberTrivia;
  const NumberTrivaReturnResult({
    this.numberTrivia,
    this.result,
  });

  NumberTrivaReturnResult.result({
    NumberTriviaResult? numberTriviaResult,
    NumberTrivia? numberTrivia,
  }) : this(
          numberTrivia: numberTrivia,
          result: numberTriviaResult,
        );

  @override
  bool operator ==(covariant NumberTrivaReturnResult other) =>
      numberTrivia == other.numberTrivia &&
      result == other.result &&
      runtimeType == other.runtimeType;

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        result,
        numberTrivia,
      ]);
}
