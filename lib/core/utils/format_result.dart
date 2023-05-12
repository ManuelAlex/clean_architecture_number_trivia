enum FormatResults {
  failure,
  success,
}

class FormatResultsWithInt {
  final FormatResults? formatResults;
  final int? number;
  FormatResultsWithInt({
    this.formatResults,
    this.number,
  });
  FormatResultsWithInt.returnThis({
    required FormatResults? formatResults,
    int? number,
  }) : this(number: number, formatResults: formatResults);
}
