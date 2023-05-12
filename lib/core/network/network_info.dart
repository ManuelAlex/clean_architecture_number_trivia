import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;
  NetworkInfoImpl({
    required this.dataConnectionChecker,
  });
  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
