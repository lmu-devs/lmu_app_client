import 'dart:async';

import 'package:core/logging.dart';
import 'package:flutter/material.dart';

class MensaStatusUpdateService extends ChangeNotifier {
  MensaStatusUpdateService() {
    _init();
  }

  Timer? _timer;
  final _appLogger = AppLogger();

  void _init() {
    final now = DateTime.now();
    final minutes = now.minute;

    int nextInterval = ((minutes ~/ 15) + 1) * 15;
    if (nextInterval == 60) nextInterval = 0;

    DateTime nextTriggerTime = DateTime(now.year, now.month, now.day, now.hour, nextInterval);
    if (nextInterval == 0) {
      nextTriggerTime = nextTriggerTime.add(const Duration(hours: 1));
    }

    final initialDelay = nextTriggerTime.difference(now);

    _timer = Timer(initialDelay, () {
      _notifyListeners();
      _timer = Timer.periodic(const Duration(minutes: 15), (timer) {
        _notifyListeners();
      });
    });
  }

  void _notifyListeners() async {
    _appLogger.logMessage('[MensaStatusUpdateService]: Updating status: ${DateTime.now()}');
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
