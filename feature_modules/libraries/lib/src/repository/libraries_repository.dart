import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';

abstract class LibrariesRepository {
}

class ConnectedLibrariesRepository implements LibrariesRepository {
  ConnectedLibrariesRepository({required this.librariesApiClient});

  final LibrariesApiClient librariesApiClient;
}
