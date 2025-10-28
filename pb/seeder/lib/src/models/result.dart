sealed class Result<T> {
  const Result();
}

final class SuccessResult<T> extends Result<T> {
  const SuccessResult(this.value);

  final T value;
}

final class FailureResult<T, E> extends Result<T> {
  const FailureResult(this.error);

  final E error;
}
