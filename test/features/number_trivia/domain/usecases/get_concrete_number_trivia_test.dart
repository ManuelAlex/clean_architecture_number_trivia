import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepostory extends Mock
    implements NumberTriaviaRepository {}

void main() {
  GetConcreteNumberTriviaUsecase usecase;
  MockNumberTriviaRepostory mockNumberTriviaRepostory;

  setUp(
    () {
      mockNumberTriviaRepostory = MockNumberTriviaRepostory();
      usecase = GetConcreteNumberTriviaUsecase(
        repository: mockNumberTriviaRepostory,
      );
      const testNumber = 1;
      const testNumberTriavia = NumberTrivia(
        triviaText: 'triviaTextTest',
        triviaNumber: testNumber,
      );
      test(
        'should get trivia from the number from repository',
        () async {
          //arrange
          when(
            mockNumberTriviaRepostory
                .getConcreteNumberTriavia(params: testNumber)
                .then(
                  (_) => const Right(
                    testNumberTriavia,
                  ),
                ),
          );
          //act
          final result = await usecase.call(
            params: const Params(number: testNumber),
          );
          //assert
          expect(
            result,
            const Right(
              testNumberTriavia,
            ),
          );

          verify(
            mockNumberTriviaRepostory.getConcreteNumberTriavia(
              params: testNumber,
            ),
          );
          verifyNoMoreInteractions(mockNumberTriviaRepostory);
        },
      );
    },
  );
}