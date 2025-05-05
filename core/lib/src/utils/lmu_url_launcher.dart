// url_launcher_service.dart

import 'dart:io';

import 'package:core/components.dart';
import 'package:core/localizations.dart';
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
  LmuUrlLauncher._();

  static LaunchMode _convertLaunchMode(LmuUrlLauncherMode mode) {
    switch (mode) {
      case LmuUrlLauncherMode.platformDefault:
        return LaunchMode.platformDefault;
      case LmuUrlLauncherMode.inAppWebView:
        return Platform.isIOS ? LaunchMode.inAppWebView : LaunchMode.inAppBrowserView;
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
            message: context.locals.app.errorLaunchWebsite,
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
          message: context.locals.app.errorOpenWebsite,
        );
        return false;
      }

      return launched;
    } catch (e) {
      if (context.mounted) {
        _showErrorToast(
          context: context,
          message: context.locals.app.errorWebsiteException(e),
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
            message: context.locals.app.errorNoEmailClient,
          );
        }
        return false;
      }

      final launched = await launchUrl(emailUri);

      if (!launched && context.mounted) {
        _showErrorToast(
          context: context,
          message: context.locals.app.errorOpenEmailClient,
        );
        return false;
      }

      return launched;
    } catch (e) {
      if (context.mounted) {
        _showErrorToast(
          context: context,
          message: context.locals.app.errorEmailException(e),
        );
      }
      return false;
    }
  }

  static Future<bool> launchPhone({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

      if (!await canLaunchUrl(phoneUri)) {
        if (context.mounted) {
          _showErrorToast(
            context: context,
            message: context.locals.app.errorLaunchDialer,
          );
        }
        return false;
      }

      final launched = await launchUrl(phoneUri);

      if (!launched && context.mounted) {
        _showErrorToast(
          context: context,
          message: context.locals.app.errorOpenDialer,
        );
        return false;
      }

      return launched;
    } catch (e) {
      if (context.mounted) {
        _showErrorToast(
          context: context,
          message: context.locals.app.errorDialerException(e),
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
