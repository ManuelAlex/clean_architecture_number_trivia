import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/core/extension/fixture_reader.dart';

void main() {
  const testNumberTriviaModel =
      NumberTriviaModel(triviaNumber: 1, triviaText: 'test text');

  test('Should be a subtype of NumberTribia entity', () {
    //arrange
    //act
    //assert
    expect(testNumberTriviaModel, isA<NumberTrivia>());
  });

  group('from json', () {
    test(
      'should return valid a model from the jsonFile given an integer  ',
      () async {
        final Map<String, dynamic> jsonMap = json.decode(
          fixtureReader('trivia.json'),
        );
        final result = NumberTriviaModel.fromJson(json: jsonMap);
        expect(
          result,
          isA<NumberTriviaModel>(),
        );
      },
    );

    test(
      'should return valid a model from the jsonFile is requarded as double  ',
      () async {
        final Map<String, dynamic> jsonMap = json.decode(
          fixtureReader('trivia_double.json'),
        );
        final result = NumberTriviaModel.fromJson(json: jsonMap);
        expect(
          result,
          isA<NumberTriviaModel>(),
        );
      },
    );
  });

  group('toJson', () {
    final result = testNumberTriviaModel.toJson();
    final expectedMap = {
      "text":
          "1e+140 is the Asaṃkhyeya, a Buddhist name for the number 10^{140}.",
      "number": 1,
    };
    expect(result, expectedMap);
  });
}
