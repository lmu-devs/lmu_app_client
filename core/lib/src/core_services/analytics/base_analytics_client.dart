abstract class BaseAnalyticsClient {
  BaseAnalyticsClient();

  Future<void> init({
    required String osVersion,
    required String appVersion,
    required String locale,
    required String theme,
  });

  Future<void> setUserProperty({
    required String name,
    required String? value,
  });

  Future<void> logClick({
    required String element,
    Map<String, Object>? parameters,
  });

  Future<void> logTimeSpent({
    required String eventName,
    required int durationInSeconds,
    Map<String, Object>? parameters,
  });

  Future<void> logSelection({
    required String contentType,
    required String itemId,
  });
}
