import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImp extends NetworkInfo {
  final DataConnectionChecker _checker;

  NetworkInfoImp({required DataConnectionChecker dataConnectionChecker})
      : _checker = dataConnectionChecker;

  @override
  Future<bool> get isConnected => _checker.hasConnection;
}
