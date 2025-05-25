import 'package:flutter/widgets.dart';

abstract class LaunchFlowApi {
  Future<void> init();

  Future<void> showedWelcomePage();

  ValueNotifier<bool> get shouldShowWelcomePageNotifier;
}
