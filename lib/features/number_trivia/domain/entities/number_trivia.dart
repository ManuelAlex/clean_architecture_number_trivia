import 'package:flutter/foundation.dart' show immutable;

@immutable
class NumberTrivia {
  final String triviaText;
  final int triviaNumber;
  const NumberTrivia({
    required this.triviaText,
    required this.triviaNumber,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumberTrivia &&
          triviaText == other.triviaText &&
          triviaNumber == other.triviaNumber;

  @override
  int get hashCode => Object.hashAll([
        triviaText,
        triviaNumber,
      ]);
}
