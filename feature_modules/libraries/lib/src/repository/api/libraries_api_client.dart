import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'libraries_api_endpoints.dart';

class LibrariesApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();
}