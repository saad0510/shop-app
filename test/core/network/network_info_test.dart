import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopping_app/core/network/network_info.dart';

class MockDataConnection extends Mock implements DataConnectionChecker {}

void main() {
  late NetworkInfoImp networkInfo;
  late MockDataConnection mockDataConnection;

  setUp(() {
    mockDataConnection = MockDataConnection();
    networkInfo = NetworkInfoImp(
      dataConnectionChecker: mockDataConnection,
    );
  });

  group("isConnected:", () {
    test(
      'should simply forward the call to DataConnection.hasConnection',
      () async {
        // arrange
        final forwardedFuture = Future.value(true);
        when(() => mockDataConnection.hasConnection)
            .thenAnswer((_) => forwardedFuture);
        // act
        final result = networkInfo.isConnected;
        // assert
        expect(result, forwardedFuture);
        verify(() => mockDataConnection.hasConnection).called(1);
      },
    );
  });
}
