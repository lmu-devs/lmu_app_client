class EnvConfig {
  static const String flavor = String.fromEnvironment('FLAVOR', defaultValue: 'prod');
  static const String apiKey = String.fromEnvironment('API_KEY', defaultValue: '');

  static bool get isDev => flavor == 'dev';
  static bool get isProd => flavor == 'prod';
}
