import 'package:number_trivia/core/errors/failures.dart';
import 'package:number_trivia/core/utils/format_result.dart';

class StringToIntConverter {
  const StringToIntConverter();
  FormatResultsWithInt stringToIntConvert({
    required String str,
  }) {
    try {
      final number = int.tryParse(str);
      if (number == null || number < 0) {
        throw const FormatException();
      }
      return FormatResultsWithInt.returnThis(
        number: number,
        formatResults: FormatResults.success,
      );
    } on FormatException {
      return FormatResultsWithInt.returnThis(
          formatResults: FormatResults.failure);
    }
  }
}

class StringToIntConvertFailures extends Failures {}
