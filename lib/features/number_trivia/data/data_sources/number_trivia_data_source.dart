import 'dart:convert';

import 'package:number_trivia/core/errors/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTriavia({
    required int number,
  });
  Future<NumberTriviaModel> getRandomNumberTriavia();
}

const url = 'http://numbersapi.com';

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;
  const NumberTriviaRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<NumberTriviaModel> getConcreteNumberTriavia(
          {required int number}) async =>
      await _getTrivia(endpoint: '$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTriavia() async =>
      await _getTrivia(endpoint: 'random');

  Future<NumberTriviaModel> _getTrivia({
    required String endpoint,
  }) async {
    final response = await client.get(
      Uri.parse(
        '$url/$endpoint',
      ),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(
        json: jsonDecode(
          response.body,
        ),
      );
    } else {
      throw ServerException();
    }
  }
}
