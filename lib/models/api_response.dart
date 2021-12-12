import 'dart:collection';

abstract class Result<T> implements HashMap {}

class Success<T> extends Result<T> {
  final T value;

  Success(this.value);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class Error<T> extends Result<T> {
  final T value;

  Error(this.value);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
