import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/usecases/no_params.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepostory extends Mock
    implements NumberTriaviaRepository {}

void main() {
  GetRandomNumberTriviaUsecase usecase;
  MockNumberTriviaRepostory mockNumberTriviaRepostory;
  setUp(
    () {
      mockNumberTriviaRepostory = MockNumberTriviaRepostory();
      usecase = GetRandomNumberTriviaUsecase(
        repository: mockNumberTriviaRepostory,
      );
      const testNumber = 1;
      const testNumberTriavia = NumberTrivia(
        triviaText: 'triviaTextTest',
        triviaNumber: testNumber,
      );
      test(
        'should get random trivia from the number from repository',
        () async {
          //arrange
          when(
            mockNumberTriviaRepostory.getRandomNumberTriavia().then(
                  (_) => const Right(
                    testNumberTriavia,
                  ),
                ),
          );
          //act
          final result = await usecase.call(
            params: NoParams(),
          );
          // assert
          expect(
            result,
            const Right(
              testNumberTriavia,
            ),
          );

          verify(
            mockNumberTriviaRepostory.getRandomNumberTriavia(),
          );
          verifyNoMoreInteractions(mockNumberTriviaRepostory);
        },
      );
    },
  );
}
