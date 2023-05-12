import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/core/usecases/no_params.dart';
import 'package:number_trivia/core/utils/format_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/constants/constants.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/number_trivia_state/number_trivia_result.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/number_trivia_state/number_trivia_state.dart';

class NumberTriviStateNotifier extends StateNotifier<NumberTriviaState> {
  final GetConcreteNumberTriviaUsecase getConcreteNumberTriviaUsecase;
  final GetRandomNumberTriviaUsecase getRandomNumberTriviaUsecase;
  final StringToIntConverter stringToIntConverter;
  final NetworkInfo networkInfo;
  NumberTriviStateNotifier({
    required this.getConcreteNumberTriviaUsecase,
    required this.getRandomNumberTriviaUsecase,
    required this.stringToIntConverter,
    required this.networkInfo,
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
        erroMessage: ConstantStrings.emptyNumber,
        numberTrivia: null,
        networkFailure: false,
        result: null,
      );
      return;
    }
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      state = const NumberTriviaState(
        isLoading: false,
        erroMessage: ConstantStrings.offlineFailure,
        numberTrivia: null,
        networkFailure: true,
        result: null,
      );
      return;
    }
    try {
      final result = await getConcreteNumberTriviaUsecase.call(
        params: Params(
          number: number,
        ),
      );
      if (result.numberTrivia == null) {
        state = const NumberTriviaState(
          isLoading: false,
          erroMessage: ConstantStrings.emptyOnlineNumber,
          networkFailure: false,
          numberTrivia: null,
          result: null,
        );
      } else if (result.result == NumberTriviaResult.success) {
        state = NumberTriviaState(
          numberTrivia: NumberTrivia(
              triviaNumber: result.numberTrivia!.triviaNumber,
              triviaText: result.numberTrivia!.triviaText),
          result: result.result,
          networkFailure: isConnected,
          isLoading: false,
          erroMessage: ConstantStrings.offlineFailure,
        );
      } else if (result.result == NumberTriviaResult.serverFailures) {
        state = NumberTriviaState(
          numberTrivia: null,
          result: result.result,
          networkFailure: isConnected,
          isLoading: false,
          erroMessage: ConstantStrings.serverFailureMessage,
        );
      }
    } catch (_) {
      state = NumberTriviaState(
        numberTrivia: null,
        result: NumberTriviaResult.isOffLine,
        networkFailure: isConnected,
        isLoading: false,
        erroMessage: ConstantStrings.offlineFailure,
      );
    }

    state = state.copyWIthIsloading(false);
  }

  Future<void> getRandomNuberTrivia() async {
    state = state.copyWIthIsloading(true);
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      state = const NumberTriviaState(
        isLoading: false,
        erroMessage: ConstantStrings.offlineFailure,
        numberTrivia: null,
        networkFailure: true,
        result: null,
      );
      return;
    }
    try {
      final result = await getRandomNumberTriviaUsecase.call(
        params: NoParams(),
      );
      if (result.numberTrivia == null) {
        state = const NumberTriviaState(
          isLoading: false,
          erroMessage: ConstantStrings.emptyOnlineNumber,
          networkFailure: false,
          numberTrivia: null,
          result: null,
        );
      } else if (result.result == NumberTriviaResult.success) {
        state = NumberTriviaState(
          numberTrivia: NumberTrivia(
              triviaNumber: result.numberTrivia!.triviaNumber,
              triviaText: result.numberTrivia!.triviaText),
          result: result.result,
          networkFailure: isConnected,
          isLoading: false,
          erroMessage: ConstantStrings.offlineFailure,
        );
      } else if (result.result == NumberTriviaResult.serverFailures) {
        state = NumberTriviaState(
          numberTrivia: null,
          result: result.result,
          networkFailure: isConnected,
          isLoading: false,
          erroMessage: ConstantStrings.serverFailureMessage,
        );
      }
    } catch (_) {
      state = NumberTriviaState(
        numberTrivia: null,
        result: NumberTriviaResult.isOffLine,
        networkFailure: isConnected,
        isLoading: false,
        erroMessage: ConstantStrings.offlineFailure,
      );
    }

    state = state.copyWIthIsloading(false);
  }
}
