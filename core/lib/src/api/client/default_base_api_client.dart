import 'dart:convert';
import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../../core_services.dart';
import '../../../logging.dart';
import '../env/env_config.dart';
import 'base_api_client.dart';

class DefaultBaseApiClient extends BaseApiClient {
  final String _localHostUrl = 'http://localhost:8001';
  final String _prodBaseUrl = 'https://api.lmu-dev.org';
  final String _devBaseUrl = 'https://api-staging.lmu-dev.org';

  Locale _locale = PlatformDispatcher.instance.locale;
  final _appLogger = AppLogger();

  bool _useLocalHost = false;

  @override
  set useLocalHost(bool value) {
    _useLocalHost = value;
  }

  @override
  set locale(Locale value) {
    _appLogger.logMessage("[BaseApiClient]: Locale set: $value");
    _locale = value;
  }

  String? _userApiKey;

  @override
  set userApiKey(String? value) {
    _userApiKey = value;
    _appLogger.logMessage("[BaseApiClient]: User API Key set: $value");
  }

  String get _baseUrl {
    if (EnvConfig.isDev) return _devBaseUrl;
    if (_useLocalHost) return _localHostUrl;
    return _prodBaseUrl;
  }

  Map<String, String> get _defaultHeaders => {
        "app-version": GetIt.I.get<SystemInfoService>().systemInfo.appVersion,
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
