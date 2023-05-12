import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/data_sources/number_trivia_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

// ignore: must_be_immutable
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late final NumberTriviaRepositoryImpl numberTriviaRepositoryImpl;
  late final MockRemoteDataSource mockRemoteDataSource;
  late final MockLocalDataSource mockLocalDataSource;
  late final MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    numberTriviaRepositoryImpl = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('get concrete number trivia', () {
    test('check if device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer(
        (_) async => true,
      );
      await numberTriviaRepositoryImpl.getConcreteNumberTriavia(params: 1);
      verify(mockNetworkInfo);
    });
  });

  group(
    'device is online',
    () {},
  );
}
