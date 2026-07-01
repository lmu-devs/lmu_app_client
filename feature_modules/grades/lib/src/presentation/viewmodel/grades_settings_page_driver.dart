import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/ects_config_usecase.dart';
import '../helpers/grades_formatting_extension.dart';

part 'grades_settings_page_driver.g.dart';

@GenerateTestDriver()
class GradesSettingsPageDriver extends WidgetDriver {
  final _ectsConfigUsecase = GetIt.I.get<EctsConfigUsecase>();

  late GradesLocalizations _gradesLocalizations;

  final _ectsController = TextEditingController();

  String get largeTitle => _gradesLocalizations.settingsTitle;

  String get ectsLabel => _gradesLocalizations.ects;

  String get ectsHint => _gradesLocalizations.ectsSetupCustomHint;

  @TestDriverDefaultValue(_TestTextEditingController())
  TextEditingController get ectsController => _ectsController;

  void onEctsChanged(String value) {
    final parsed = parseTotalEcts(value);
    if (parsed != null && parsed != _ectsConfigUsecase.totalEcts) {
      _ectsConfigUsecase.setTotalEcts(parsed);
    }
    notifyWidget();
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    final currentEcts = _ectsConfigUsecase.totalEcts;
    if (currentEcts != null) {
      _ectsController.text = currentEcts.asEctsString;
    }
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _gradesLocalizations = context.locals.grades;
  }

  @override
  void dispose() {
    _ectsController.dispose();
    super.dispose();
  }
}

class _TestTextEditingController extends EmptyDefault implements TextEditingController {
  const _TestTextEditingController();
}
