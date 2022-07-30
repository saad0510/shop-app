import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

// TODO: make dependencies private

class NetworkInfoImp extends NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;

  NetworkInfoImp({required this.dataConnectionChecker});

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
