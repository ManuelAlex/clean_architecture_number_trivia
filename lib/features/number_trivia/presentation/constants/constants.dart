import 'package:flutter/foundation.dart' show immutable;

@immutable
class ConstantStrings {
  const ConstantStrings._();
  static const appName = 'Number Trivia';
  static String absentText = 'Input a number';
  static String networkError = 'Network Error';
  static const fetchingData = 'Fetching data ...';

//Riverpod folder const
  static const unCaughtFailureMessage = 'SOME UNEXPECTED ERROR';
  static const offlineFailure =
      'YOUR DEVICE IS OFFLINE - check your Internet Connection';
  static const serverFailureMessage = 'SERVER FAILURE - something went wrong';
  static const cacheFailureMessage =
      'CACHE FAILURE - unable to cache local data';
  static const invalidInputMessage =
      'INVALID INPUT - the number must be a positive integer or zero';
  static const emptyNumber = 'EMPTY FEILD - please a number';
  static const emptyOnlineNumber =
      'sorry We were unable to resolve the trivia  - try again';
}
