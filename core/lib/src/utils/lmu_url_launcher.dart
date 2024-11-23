// url_launcher_service.dart

import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Custom enum for URL launch modes without exposing url_launcher dependency
enum LmuUrlLauncherMode {
  platformDefault,
  inAppWebView,
  externalApplication,
  externalNonBrowserApplication,
}

/// Service class for handling all external launching operations (URLs, emails, etc.)
/// Provides consistent error handling and user feedback
class LmuUrlLauncher {
  static LaunchMode _convertLaunchMode(LmuUrlLauncherMode mode) {
    switch (mode) {
      case LmuUrlLauncherMode.platformDefault:
        return LaunchMode.platformDefault;
      case LmuUrlLauncherMode.inAppWebView:
        return LaunchMode.inAppWebView;
      case LmuUrlLauncherMode.externalApplication:
        return LaunchMode.externalApplication;
      case LmuUrlLauncherMode.externalNonBrowserApplication:
        return LaunchMode.externalNonBrowserApplication;
    }
  }

  static Future<bool> canLaunch({required String url}) async {
    final Uri uri = Uri.parse(url);
    return await canLaunchUrl(uri);
  }

  /// Launches a website URL with error handling and user feedback
  ///
  /// Parameters:
  /// - [url]: The URL to launch
  /// - [context]: BuildContext for showing feedback
  /// - [mode]: LaunchMode to determine how the URL should be opened
  ///
  /// Returns a Future<bool> indicating success/failure
  static Future<bool> launchWebsite({
    required String url,
    required BuildContext context,
    LmuUrlLauncherMode mode = LmuUrlLauncherMode.platformDefault,
  }) async {
    try {
      final Uri uri = Uri.parse(url);

      // Verify URL can be launched
      if (!await canLaunchUrl(uri)) {
        if (context.mounted) {
          _showErrorToast(
            context: context,
            message: 'Could not launch website',
          );
        }
        return false;
      }

      // Launch URL
      final launched = await launchUrl(
        uri,
        mode: _convertLaunchMode(mode),
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      );

      if (!launched && context.mounted) {
        _showErrorToast(
          context: context,
          message: 'Failed to open website',
        );
        return false;
      }

      return launched;
    } catch (e) {
      if (context.mounted) {
        _showErrorToast(
          context: context,
          message: 'Error launching website: $e',
        );
      }
      return false;
    }
  }

  static Future<bool> launchEmail({
    required String email,
    String? subject,
    String? body,
    required BuildContext context,
  }) async {
    try {
      // Create the mailto URI with raw spaces
      final emailUri = Uri.parse('mailto:$email?${[
        if (subject != null) 'subject=$subject',
        if (body != null) 'body=$body',
      ].join('&')}');

      if (!await canLaunchUrl(emailUri)) {
        if (context.mounted) {
          _showErrorToast(
            context: context,
            message: 'No email client found',
          );
        }
        return false;
      }

      final launched = await launchUrl(emailUri);

      if (!launched && context.mounted) {
        _showErrorToast(
          context: context,
          message: 'Failed to launch email client',
        );
        return false;
      }

      return launched;
    } catch (e) {
      if (context.mounted) {
        _showErrorToast(
          context: context,
          message: 'Error launching email client: $e',
        );
      }
      return false;
    }
  }

  /// Shows an error message using a Toast
  ///
  /// Parameters:
  /// - [context]: BuildContext for showing the SnackBar
  /// - [message]: Error message to display
  static void _showErrorToast({
    required BuildContext context,
    required String message,
  }) {
    LmuToast.show(context: context, message: message, type: ToastType.error);
  }
}
