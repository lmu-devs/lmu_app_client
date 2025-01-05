class FeedbackApiEndpoints {
  static const String _baseUrl = "https://api.lmu-dev.org";

  static const String _version = '/v1';

  static const String _feedbackRoute = '/feedback';

  static String saveFeedback() {
    return '$_baseUrl$_version$_feedbackRoute';
  }
}
