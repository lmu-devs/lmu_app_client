import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

class AppLogger {
  factory AppLogger() {
    return _instance;
  }

  AppLogger._internal() {
    _setupLogging();
  }

  static final AppLogger _instance = AppLogger._internal();
  final Logger _logger = Logger("AppLogger");
  File? _logFile;
  final ValueNotifier<List<String>> _logsNotifier = ValueNotifier([]);

  ValueNotifier<List<String>> get logsNotifier => _logsNotifier;

  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    _logFile = File('${directory.path}/app_logs.txt');

    if (!(await _logFile!.exists())) {
      await _logFile!.create();
    }

    clearLogs();
  }

  void _setupLogging() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) async {
      final logMessage = '[${record.level.name}] ${record.time.toIso8601String()}: ${record.message}';
      _logsNotifier.value = [..._logsNotifier.value, logMessage];
      debugPrint(logMessage);

      await _logFile?.writeAsString('$logMessage\n', mode: FileMode.append);
    });

    logMessage('App started');
  }

  void logMessage(String message, {Level level = Level.INFO}) {
    _logger.log(level, message);
  }

  void logError(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.severe(message, error, stackTrace);
  }

  Future<List<String>> getLogs() async {
    if (await _logFile?.exists() ?? false) {
      return await _logFile!.readAsLines();
    }
    return [];
  }

  String get logFilePath => _logFile?.path ?? '';

  Future<void> clearLogs() async {
    await _logFile?.writeAsString('');
    _logsNotifier.value = [];
  }
}
