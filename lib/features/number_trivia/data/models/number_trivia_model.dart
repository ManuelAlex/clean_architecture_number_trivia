import 'package:flutter/foundation.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

@immutable
class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required String triviaText,
    required int triviaNumber,
  }) : super(
          triviaNumber: triviaNumber,
          triviaText: triviaText,
        );

  NumberTriviaModel.fromJson({
    required Map<String, dynamic> json,
  }) : this(
          triviaNumber: (json['number'] as num).toInt(),
          triviaText: json['text'],
        );

  Map<String, dynamic> toJson() => {
        "text": triviaText,
        "number": triviaNumber,
      };
}
