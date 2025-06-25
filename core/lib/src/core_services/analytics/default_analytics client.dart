import 'package:firebase_analytics/firebase_analytics.dart';

import 'analytics.dart';

class DefaultAnalyticsClient extends AnalyticsClient {

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> init({
    required String osVersion,
    required String appVersion,
    required String locale,
    required String theme,
  }) async {
    await Future.wait([
      _analytics.setUserProperty(name: 'os_version', value: osVersion),
      _analytics.setUserProperty(name: 'app_version', value: appVersion),
      _analytics.setUserProperty(name: 'locale', value: locale),
      _analytics.setUserProperty(name: 'theme', value: theme),
    ]);
  }

  @override
  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  @override
  Future<void> logClick({
    required String eventName,
    Map<String, Object>? parameters,
  }) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: {
        ...?parameters,
      },
    );
  }

  @override
  Future<void> logTimeSpent({
    required String eventName,
    required int durationInSeconds,
    Map<String, Object>? parameters,
  }) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: {
        'duration_seconds': durationInSeconds,
        ...?parameters,
      },
    );
  }

  @override
  Future<void> logSelection({
    required String contentType,
    required String itemId,
  }) async {
    await _analytics.logSelectContent(contentType: contentType, itemId: itemId);
  }
}
