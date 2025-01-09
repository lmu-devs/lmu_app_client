import 'dart:async';

import 'package:flutter/material.dart';

class MensaStatusUpdateService extends ChangeNotifier {
  void init() {
    _startTimer();
  }

  Timer? _timer;

  void _startTimer() {
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
      notifyListeners(); // Trigger the first event
      _timer = Timer.periodic(const Duration(minutes: 15), (timer) {
        notifyListeners();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
