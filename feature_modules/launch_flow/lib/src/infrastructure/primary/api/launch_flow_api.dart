import 'dart:async';

import 'package:core/logging.dart';
import 'package:core/utils.dart';
import 'package:core_routes/home.dart';
import 'package:core_routes/launch_flow.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/launch_flow.dart';
import 'package:shared_api/studies.dart';

import '../../../application/usecase/get_feature_flags_usecase.dart';
import '../../../application/usecase/get_release_notes_usecase.dart';
import '../../../domain/interface/launch_flow_repository_interface.dart';

class LaunchFlowApiImpl extends LaunchFlowApi {
  LaunchFlowApiImpl(
    this._repository,
    this._getReleaseNotesUsecase,
    this._getFeatureFlagsUsecase,
    this._facultiesApi,
  );

  final LaunchFlowRepositoryInterface _repository;
  final GetReleaseNotesUsecase _getReleaseNotesUsecase;
  final GetFeatureFlagsUsecase _getFeatureFlagsUsecase;
  final FacultiesApi _facultiesApi;

  final List<String> _routes = [];
  int _currentIndex = 0;

  final _defaultTimeout = const Duration(seconds: 2);

  @override
  String get initialLocation => _routes.isNotEmpty ? _routes.first : const HomeMainRoute().location;

  @override
  Future<void> init() async {
    final stopwatch = Stopwatch()..start();

    final results = await Future.wait(
      _launchSteps.map((step) => step.condition()),
    );

    _routes.clear();

    for (int i = 0; i < _launchSteps.length; i++) {
      if (results[i]) {
        _routes.add(_launchSteps[i].route);
      }
    }

    stopwatch.stop();
    AppLogger().logMessage(
      "[LaunchFlowApi] Init completed in ${stopwatch.elapsedMilliseconds}ms with routes: ${_routes.join(', ')}",
    );
  }

  @override
  void continueFlow(BuildContext context) {
    if (_currentIndex < _routes.length - 1) {
      _currentIndex++;
      final nextRoute = _routes[_currentIndex];
      context.pushReplacement(nextRoute);
    } else {
      const HomeMainRoute().pushReplacement(context);
    }
  }

  List<LaunchStep> get _launchSteps => [
        LaunchStep(
          name: "App Update",
          route: const LaunchFlowAppUpdateRoute().location,
          condition: () => _getFeatureFlagsUsecase.loadFeatureFlags().timeout(_defaultTimeout, onTimeout: () => false),
        ),
        LaunchStep(
          name: "Welcome Page",
          route: const LaunchFlowWelcomeRoute().location,
          condition: () => _repository.shouldShowWelcomePage(),
        ),
        LaunchStep(
          name: "Faculty Selection",
          route: const LaunchFlowFacultySelectionRoute().location,
          condition: () => _checkStreamForEventIfConditionMet(
            stream: _facultiesApi.selectedFacultiesStream,
            initialValue: _facultiesApi.selectedFaculties,
            conditionFuture: _repository.shouldShowFacultySelectionPage(),
            predicate: (faculties) => faculties.isEmpty,
            timeout: _defaultTimeout,
          ),
        ),
        LaunchStep(
          name: "Release Notes",
          route: const LaunchFlowReleaseNotesRoute().location,
          condition: () => _getReleaseNotesUsecase.loadReleaseNotes().timeout(_defaultTimeout, onTimeout: () => false),
        ),
      ];
}

class LaunchStep {
  const LaunchStep({
    required this.name,
    required this.route,
    required this.condition,
  });

  final String name;
  final String route;
  final Future<bool> Function() condition;
}

Future<bool> _checkStreamForEventIfConditionMet<T>({
  required Stream<T> stream,
  required T initialValue,
  required Future<bool> conditionFuture,
  required bool Function(T value)? predicate,
  required Duration timeout,
}) async {
  final shouldListen = await conditionFuture;
  if (!shouldListen) return false;

  final test = predicate ?? (value) => value != null;

  try {
    await stream.withInitialValue(initialValue).firstWhere(test).timeout(timeout);
    return true;
  } on TimeoutException {
    return false;
  } on StateError {
    return false;
  }
}
