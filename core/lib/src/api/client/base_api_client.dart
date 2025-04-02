import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

abstract class BaseApiClient {
  set userApiKey(String? value);

  set useLocalHost(bool value);

  set locale(Locale value);

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
