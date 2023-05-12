import 'package:flutter/foundation.dart' show immutable;
import 'package:collection/collection.dart';

@immutable
abstract class Failures {
  final List<dynamic> failureProperties;
  const Failures({
    this.failureProperties = const [],
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failures &&
          runtimeType == other.runtimeType &&
          const ListEquality().equals(
            failureProperties,
            other.failureProperties,
          );

  @override
  int get hashCode => Object.hashAll([
        failureProperties,
        runtimeType,
      ]);
}

class ServerFailures implements Failures {
  @override
  List get failureProperties => ['Server Failure'];
}

class CacheFailures implements Failures {
  @override
  List get failureProperties => ['cache Failure'];
  // List get failureProperties => throw UnimplementedError();
}
