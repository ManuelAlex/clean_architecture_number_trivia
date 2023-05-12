import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_trivia/core/usecases/no_params.dart';
import 'package:number_trivia/core/utils/format_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/number_trivia_state/number_trivia_result.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/number_trivia_state/number_trivia_state.dart';

const unCaughtFailureMessage = 'SOME UNEXPECTED ERROR';
const offlineFailure = 'YOUR DEVICE IS OFFLINE';
const serverFailureMessage = 'SERVER FAILURE - check your Internet Connection ';
const cacheFailureMessage = 'CACHE FAILURE - unable to cache local data';
const invalidInputMessage =
    'INVALID INPUT - the number must be a positive integer or zero';
const emptyNumber = 'EMPTY FEILD - please a number';

class NumberTriviStateNotifier extends StateNotifier<NumberTriviaState> {
  final GetConcreteNumberTriviaUsecase getConcreteNumberTriviaUsecase;
  final GetRandomNumberTriviaUsecase getRandomNumberTriviaUsecase;
  final StringToIntConverter stringToIntConverter;
  NumberTriviStateNotifier({
    required this.getConcreteNumberTriviaUsecase,
    required this.getRandomNumberTriviaUsecase,
    required this.stringToIntConverter,
  }) : super(
          const NumberTriviaState.empty(),
        );

  Future<void> getConcreteNuberTrivia({required String numString}) async {
    state = state.copyWIthIsloading(true);
    final number =
        stringToIntConverter.stringToIntConvert(str: numString).number;
    if (number == null) {
      state = const NumberTriviaState(
        isLoading: false,
        erroMessage: emptyNumber,
        numberTrivia: null,
        result: null,
      );
      return;
    }

    final result = await getConcreteNumberTriviaUsecase.call(
      params: Params(
        number: number,
      ),
    );
    if (result.numberTrivia == null) {
      state = const NumberTriviaState(
        isLoading: false,
        erroMessage: emptyNumber,
        numberTrivia: null,
        result: null,
      );
    }
    print(result.numberTrivia!.triviaText + 'notifier concrete');
    switch (result.result) {
      case NumberTriviaResult.success:
        state = NumberTriviaState(
          numberTrivia: NumberTrivia(
              triviaNumber: result.numberTrivia!.triviaNumber,
              triviaText: result.numberTrivia!.triviaText),
          result: result.result,
          isLoading: false,
          erroMessage: offlineFailure,
        );
        break;
      case NumberTriviaResult.isOffLine:
        state = NumberTriviaState(
          numberTrivia: null,
          result: result.result,
          isLoading: false,
          erroMessage: offlineFailure,
        );
        break;
      case NumberTriviaResult.serverFailures:
        state = NumberTriviaState(
          numberTrivia: null,
          result: result.result,
          isLoading: false,
          erroMessage: serverFailureMessage,
        );
        break;
      case NumberTriviaResult.cacheFailures:
        state = NumberTriviaState(
          numberTrivia: null,
          result: result.result,
          isLoading: false,
          erroMessage: cacheFailureMessage,
        );
        break;

      default:
        state = const NumberTriviaState.empty();
    }
  }

  Future<void> getRandomNuberTrivia() async {
    state = state.copyWIthIsloading(true);

    final result = await getRandomNumberTriviaUsecase.call(
      params: NoParams(),
    );
    print(result.numberTrivia!.triviaText + 'notifier random');
    switch (result.result) {
      case NumberTriviaResult.success:
        state = NumberTriviaState(
          numberTrivia: NumberTrivia(
              triviaNumber: result.numberTrivia!.triviaNumber,
              triviaText: result.numberTrivia!.triviaText),
          result: result.result,
          isLoading: false,
          erroMessage: null,
        );
        break;
      case NumberTriviaResult.isOffLine:
        state = NumberTriviaState(
          numberTrivia: null,
          result: result.result,
          isLoading: false,
          erroMessage: offlineFailure,
        );
        break;
      case NumberTriviaResult.serverFailures:
        state = NumberTriviaState(
          numberTrivia: null,
          result: result.result,
          isLoading: false,
          erroMessage: serverFailureMessage,
        );
        break;
      case NumberTriviaResult.cacheFailures:
        state = NumberTriviaState(
          numberTrivia: null,
          result: result.result,
          isLoading: false,
          erroMessage: cacheFailureMessage,
        );
        break;

      default:
        state = NumberTriviaState(
          numberTrivia: null,
          result: result.result,
          isLoading: false,
          erroMessage: unCaughtFailureMessage,
        );
    }
  }
}
