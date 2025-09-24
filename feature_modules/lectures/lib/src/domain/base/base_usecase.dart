import 'package:flutter/foundation.dart';

/// Base class for use cases with common state management patterns
abstract class BaseUsecase {
  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  /// Add listener to all notifiers
  void addListener(VoidCallback listener) {
    if (_isDisposed) return;
    addListenersToNotifiers(listener);
  }

  /// Remove listener from all notifiers
  void removeListener(VoidCallback listener) {
    if (_isDisposed) return;
    removeListenersFromNotifiers(listener);
  }

  /// Dispose all resources
  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;
    disposeNotifiers();
  }

  /// Override to add listeners to specific notifiers
  void addListenersToNotifiers(VoidCallback listener);

  /// Override to remove listeners from specific notifiers
  void removeListenersFromNotifiers(VoidCallback listener);

  /// Override to dispose specific notifiers
  void disposeNotifiers();
}
