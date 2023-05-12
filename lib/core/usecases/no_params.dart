class NoParams {
  @override
  bool operator ==(covariant NoParams other) =>
      runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
