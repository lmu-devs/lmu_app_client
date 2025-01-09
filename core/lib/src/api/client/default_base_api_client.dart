import 'dart:convert';
import 'dart:ui';

import 'package:core/logging.dart';
import 'package:http/http.dart' as http;

import 'base_api_client.dart';

class DefaultBaseApiClient extends BaseApiClient {
  final String _localHostUrl = 'http://localhost:8001';
  final String _prodBaseUrl = 'https://api.lmu-dev.org';
  final String _devBaseUrl = 'https://dev-api.lmu-dev.org';

  final _locale = PlatformDispatcher.instance.locale;
  final _appLogger = AppLogger();

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
    _appLogger.logMessage("[BaseApiClient]: User API Key set: $value");
  }

  String get _baseUrl => _useLocalHost
      ? _localHostUrl
      : _isDevEnv
          ? _devBaseUrl
          : _prodBaseUrl;

  Map<String, String> get _defaultHeaders => {
        "accept-language": _locale.languageCode,
        if (_userApiKey != null) "user-api-key": _userApiKey!,
      };

  Future<http.Response> _makeRequest(
    String method,
    String endpoint, {
    int version = 1,
    Map<String, String>? additionalHeaders,
    Object? body,
    Encoding? encoding,
  }) async {
    final constructedUrl = Uri.parse('$_baseUrl/v$version$endpoint');
    final headers = {
      ..._defaultHeaders,
      if (additionalHeaders != null) ...additionalHeaders,
    };

    final stopwatch = Stopwatch()..start();

    _appLogger.logMessage("[BaseApiClient][$method]: URL: $constructedUrl, Headers: $headers, Body: ${body ?? "N/A"}");

    late http.Response response;

    try {
      switch (method) {
        case 'GET':
          response = await http.get(constructedUrl, headers: headers);
          break;
        case 'POST':
          response = await http.post(
            constructedUrl,
            headers: headers,
            body: body,
            encoding: encoding,
          );
          break;
        case 'PUT':
          response = await http.put(
            constructedUrl,
            headers: headers,
            body: body,
            encoding: encoding,
          );
          break;
        case 'DELETE':
          response = await http.delete(constructedUrl, headers: headers);
          break;
        default:
          throw UnsupportedError("HTTP method $method is not supported.");
      }

      stopwatch.stop();

      if (response.statusCode == 200) {
        final truncatedBody = _truncateBody(response.body, 25);
        _appLogger.logMessage(
            "[BaseApiClient][$method]: SUCCESS Response from $constructedUrl in ${stopwatch.elapsedMilliseconds}ms, "
            "StatusCode: ${response.statusCode}, Body: $truncatedBody");
      } else {
        _logError(method, constructedUrl, headers, response, stopwatch.elapsedMilliseconds);
      }
    } catch (e, stackTrace) {
      stopwatch.stop();
      _appLogger.logError(
          "[BaseApiClient][$method]: Exception for $constructedUrl after ${stopwatch.elapsedMilliseconds}ms",
          error: e,
          stackTrace: stackTrace);
      rethrow;
    }

    return response;
  }

  String _truncateBody(String body, int maxLength) {
    if (body.isEmpty) return "N/A";
    return body.length <= maxLength ? body : "${body.substring(0, maxLength)}...";
  }

  void _logError(
    String method,
    Uri url,
    Map<String, String> headers,
    http.Response response,
    int elapsedMilliseconds,
  ) {
    _appLogger.logError("[BaseApiClient][$method]: ERROR Response from $url in ${elapsedMilliseconds}ms, "
        "StatusCode: ${response.statusCode}, Headers: ${response.headers}, Body: ${response.body}");
  }

  @override
  Future<http.Response> get(
    String endpoint, {
    int version = 1,
    Map<String, String>? additionalHeaders,
  }) =>
      _makeRequest('GET', endpoint, version: version, additionalHeaders: additionalHeaders);

  @override
  Future<http.Response> post(
    String endpoint, {
    int version = 1,
    Map<String, String>? additionalHeaders,
    Object? body,
    Encoding? encoding,
  }) =>
      _makeRequest('POST', endpoint,
          version: version, additionalHeaders: additionalHeaders, body: body, encoding: encoding);

  @override
  Future<http.Response> put(
    String endpoint, {
    int version = 1,
    Map<String, String>? additionalHeaders,
    Object? body,
    Encoding? encoding,
  }) =>
      _makeRequest('PUT', endpoint,
          version: version, additionalHeaders: additionalHeaders, body: body, encoding: encoding);

  @override
  Future<http.Response> delete(
    String endpoint, {
    int version = 1,
    Map<String, String>? additionalHeaders,
  }) =>
      _makeRequest('DELETE', endpoint, version: version, additionalHeaders: additionalHeaders);
}
