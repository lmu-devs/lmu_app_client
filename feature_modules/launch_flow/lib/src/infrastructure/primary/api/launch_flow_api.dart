import 'package:flutter/material.dart';
import 'package:shared_api/launch_flow.dart';

import '../../../application/usecase/should_show_welcome_page_usecase.dart';
import '../../../application/usecase/showed_welcome_page_usecase.dart';

class LaunchFlowApiImpl extends LaunchFlowApi {
  LaunchFlowApiImpl(this._shouldShowWelcomePageUsecase, this._showedWelcomePageUsecase);

  final ShouldShowWelcomePageUsecase _shouldShowWelcomePageUsecase;
  final ShowedWelcomePageUsecase _showedWelcomePageUsecase;

  final _shouldShowWelcomePageNotifier = ValueNotifier(false);

  @override
  Future<void> init() async {
    final shouldShowWelcomePage = await _shouldShowWelcomePageUsecase.call();
    _shouldShowWelcomePageNotifier.value = shouldShowWelcomePage;
  }

  @override
  Future<void> showedWelcomePage() async {
    _shouldShowWelcomePageNotifier.value = false;
    await _showedWelcomePageUsecase.call();
  }

  @override
  ValueNotifier<bool> get shouldShowWelcomePageNotifier => _shouldShowWelcomePageNotifier;
}
