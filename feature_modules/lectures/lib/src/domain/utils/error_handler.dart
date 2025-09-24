import 'package:flutter/foundation.dart';

import '../exception/lectures_generic_exception.dart';

/// Common error handling utilities for the lectures module
class ErrorHandler {
  /// Handle API errors with consistent error messages
  static LecturesGenericException handleApiError(dynamic error, String context) {
    if (error is LecturesGenericException) {
      return error;
    }
    
    final message = _getErrorMessage(error);
    return LecturesGenericException('$context: $message');
  }

  /// Handle storage errors with consistent error messages
  static LecturesGenericException handleStorageError(dynamic error, String context) {
    if (error is LecturesGenericException) {
      return error;
    }
    
    final message = _getErrorMessage(error);
    return LecturesGenericException('$context: $message');
  }

  /// Get user-friendly error message
  static String _getErrorMessage(dynamic error) {
    if (error == null) return 'Unknown error';
    
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('network') || errorString.contains('connection')) {
      return 'Network connection failed. Please check your internet connection.';
    }
    
    if (errorString.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    
    if (errorString.contains('unauthorized') || errorString.contains('401')) {
      return 'Authentication failed. Please log in again.';
    }
    
    if (errorString.contains('forbidden') || errorString.contains('403')) {
      return 'Access denied. You don\'t have permission to access this resource.';
    }
    
    if (errorString.contains('not found') || errorString.contains('404')) {
      return 'Requested resource not found.';
    }
    
    if (errorString.contains('server') || errorString.contains('500')) {
      return 'Server error. Please try again later.';
    }
    
    return 'An unexpected error occurred. Please try again.';
  }

  /// Log error with context
  static void logError(dynamic error, String context) {
    if (kDebugMode) {
      debugPrint('Error in $context: $error');
    }
  }
}
