import 'package:number_trivia/core/errors/exceptions.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/number_trivia_state/number_trivia_result.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/data_sources/number_trivia_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

// typedef GetConcretOrRandonTriva = Future<NumberTriviaResult> Function({
//   required Function getConcreteOrRandom,
// });

class NumberTriviaRepositoryImpl extends NumberTriaviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  NumberTriviaRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<NumberTrivaReturnResult> getConcreteNumberTriavia(
          {required int params}) async =>
      await _getConcreteOrRandomNumberTriavia(
        getConOrRand: remoteDataSource.getConcreteNumberTriavia(number: params),
      );

  @override
  Future<NumberTrivaReturnResult> getRandomNumberTriavia() async {
    final result = await _getConcreteOrRandomNumberTriavia(
      getConOrRand: remoteDataSource.getRandomNumberTriavia(),
    );
    // print(result.numberTrivia!.triviaText + 'second repo impl');
    return result;
  }

  Future<NumberTrivaReturnResult> _getConcreteOrRandomNumberTriavia({
    required Future<NumberTriviaModel> getConOrRand,
  }) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteNumberTrivia = await getConOrRand;
        await localDataSource.cachedNumberTrivia(
          triviaToCache: remoteNumberTrivia,
        );

        //  print(remoteNumberTrivia.triviaText + 'repoIMpl');

        return NumberTrivaReturnResult(
            numberTrivia: NumberTrivia(
                triviaNumber: remoteNumberTrivia.triviaNumber,
                triviaText: remoteNumberTrivia.triviaText));
      } on ServerException {
        return const NumberTrivaReturnResult(
            result: NumberTriviaResult.serverFailures);
      }
    } else {
      try {
        return const NumberTrivaReturnResult(
            result: NumberTriviaResult.isOffLine);
      } on CacheException {
        return const NumberTrivaReturnResult(
            result: NumberTriviaResult.cacheFailures);
      }
    }
  }
}
