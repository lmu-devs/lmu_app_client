import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class LaunchFlowApi extends ChangeNotifier {
  Future<void> init();

  String get initialLocation;

  void continueFlow(BuildContext context);
}
