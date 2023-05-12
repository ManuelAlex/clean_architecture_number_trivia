import 'dart:convert';
import 'package:number_trivia/core/errors/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cachedNumberTrivia({
    required NumberTriviaModel triviaToCache,
  });
}

const catchedNumberTrivia = 'CACHE_NUMBER_TRIVIA';
const catchedNumberTriviaException = 'CACHE_NUMBER_TRIVIA is empty';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<bool> cachedNumberTrivia({
    required NumberTriviaModel triviaToCache,
  }) async {
    try {
      final cachedJson = sharedPreferences.setString(
          catchedNumberTrivia, jsonEncode(triviaToCache));
      return Future.value(
        cachedJson,
      );
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(
      catchedNumberTriviaException,
    );
    if (jsonString == null) {
      throw CacheException();
    }
    return Future.value(
      jsonDecode(jsonString),
    );
  }
}
