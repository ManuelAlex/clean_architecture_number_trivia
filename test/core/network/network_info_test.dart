import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:number_trivia/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  late MockDataConnectionChecker mockDataConnectionChecker;
  late NetworkInfoImpl netWorkInfoImpl;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    netWorkInfoImpl = NetworkInfoImpl(
      dataConnectionChecker: mockDataConnectionChecker,
    );
  });
  group("isConnected", () {
    test('should make call to data connection checker.hasConnection', () {
      when(mockDataConnectionChecker.hasConnection).thenAnswer(
        (_) async => true,
      );
      final result = netWorkInfoImpl.isConnected;
      verify(mockDataConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}
