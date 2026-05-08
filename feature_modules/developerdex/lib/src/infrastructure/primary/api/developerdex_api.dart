import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_api/developerdex.dart';

import '../../../application/usecase/get_developerdex_usecase.dart';
import '../../../domain/model/lmu_developer.dart';
import '../../../domain/model/rarity.dart';
import '../../../presentation/component/developerdex_encounter.dart';

class DeveloperdexApiImpl extends DeveloperdexApi {
  DeveloperdexApiImpl(this._getDeveloperdexUsecase) : _random = Random();

  final GetDeveloperdexUsecase _getDeveloperdexUsecase;
  final Random _random;

  @override
  Widget? getDeveloperEncounter() {
    final allDevelopers = _getDeveloperdexUsecase.semesterCourses.expand((course) => course.developers).toList();
    final selectedDeveloper = getEncounter(allDevelopers);

    if (selectedDeveloper == null) return null;

    return DeveloperEncounter(developer: selectedDeveloper);
  }

  LmuDeveloper? getEncounter<T>(List<LmuDeveloper> developers) {
    final rand = _random.nextDouble();

    double cumulative = 0.0;
    for (final entry in developers) {
      cumulative += entry.rarity.encounterProbability;
      if (rand < cumulative) {
        return entry;
      }
    }
    return null;
  }
}
