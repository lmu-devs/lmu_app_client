extension StreamWithInitialValue<T> on Stream<T> {
  /// Set an initial value to be used when listening to a stream.
  ///
  /// This is especially useful when the stream subscribed to does not have an
  /// initial value and a subsequent listener should be invoked on distinct()
  /// changes only.
  Stream<T> withInitialValue(T initialValue) async* {
    yield initialValue;
    yield* this;
  }
}
