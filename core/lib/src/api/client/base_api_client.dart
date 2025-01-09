import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class BaseApiClient {
  set userApiKey(String? value);

  set isDevEnv(bool value);

  set useLocalHost(bool value);

  Future<http.Response> get(
    String endpoint, {
    int version = 1,
    Map<String, String>? additionalHeaders,
  });

  Future<http.Response> post(
    String endpoint, {
    int version = 1,
    Map<String, String>? additionalHeaders,
    Object? body,
    Encoding? encoding,
  });

  Future<http.Response> put(
    String endpoint, {
    int version = 1,
    Map<String, String>? additionalHeaders,
    Object? body,
    Encoding? encoding,
  });

  Future<http.Response> delete(
    String endpoint, {
    int version = 1,
    Map<String, String>? additionalHeaders,
  });
}