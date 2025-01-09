import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart' as http;

import 'base_api_client.dart';

class DefaultBaseApiClient extends BaseApiClient {
  final String _localHostUrl = 'http://localhost:8001';
  final String _prodBaseUrl = 'https://api.lmu-dev.org';
  final String _devBaseUrl = 'https://dev-api.lmu-dev.org'; //TBD

  final locale = PlatformDispatcher.instance.locale;

  bool _isDevEnv = false;
  @override
  set isDevEnv(bool value) {
    _isDevEnv = value;
  }

  bool _useLocalHost = false;
  @override
  set useLocalHost(bool value) {
    _useLocalHost = value;
  }

  String? _userApiKey;
  @override
  set userApiKey(String? value) {
    _userApiKey = value;
    print("Set user api key in base api client: $value");
  }

  String get _baseUrl => _useLocalHost
      ? _localHostUrl
      : _isDevEnv
          ? _devBaseUrl
          : _prodBaseUrl;

  Map<String, String> get _defaultHeaders => {
        "accept-language": locale.languageCode,
        if (_userApiKey != null) "user-api-key": _userApiKey!,
      };

  @override
  Future<http.Response> get(
    String endpoint, {
    int version = 1,
    Map<String, String>? additionalHeaders,
  }) async {
    final constructedUrl = Uri.parse('$_baseUrl/v$version$endpoint');

    return await http.get(
      constructedUrl,
      headers: {
        ..._defaultHeaders,
        if (additionalHeaders != null) ...additionalHeaders,
      },
    );
  }

  @override
  Future<http.Response> post(
    String endpoint, {
    int version = 1,
    Map<String, String>? additionalHeaders,
    Object? body,
    Encoding? encoding,
  }) async {
    final constructedUrl = Uri.parse('$_baseUrl/v$version$endpoint');

    return await http.post(
      constructedUrl,
      headers: {
        ..._defaultHeaders,
        if (additionalHeaders != null) ...additionalHeaders,
      },
      body: body,
      encoding: encoding,
    );
  }

  @override
  Future<http.Response> put(
    String endpoint, {
    int version = 1,
    Map<String, String>? additionalHeaders,
    Object? body,
    Encoding? encoding,
  }) async {
    final constructedUrl = Uri.parse('$_baseUrl/v$version$endpoint');

    return await http.put(
      constructedUrl,
      headers: {
        ..._defaultHeaders,
        if (additionalHeaders != null) ...additionalHeaders,
      },
      body: body,
      encoding: encoding,
    );
  }

  @override
  Future<http.Response> delete(
    String endpoint, {
    int version = 1,
    Map<String, String>? additionalHeaders,
  }) async {
    final constructedUrl = Uri.parse('$_baseUrl/v$version$endpoint');

    return await http.delete(
      constructedUrl,
      headers: {
        ..._defaultHeaders,
        if (additionalHeaders != null) ...additionalHeaders,
      },
    );
  }
}
