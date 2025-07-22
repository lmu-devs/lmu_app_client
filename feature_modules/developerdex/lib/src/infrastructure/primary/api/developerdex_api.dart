import 'dart:math';

import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_api/developerdex.dart';

import '../../../application/usecase/get_developerdex_usecase.dart';
import '../../../presentation/component/developerdex_encounter.dart';

class DeveloperdexApiImpl extends DeveloperdexApi {
  DeveloperdexApiImpl(this._getDeveloperdexUsecase);

  final GetDeveloperdexUsecase _getDeveloperdexUsecase;

  static const _encounterPercentage = 0.1;

  @override
  Widget? getDeveloperEncounter() {
    final allDevelopers = _getDeveloperdexUsecase.semesterCourses.expand((course) => course.developers).toList();

    final random = Random();
    if (random.nextDouble() > _encounterPercentage) {
      return null;
    }

    return DeveloperEncounter(
      assetName: LmuAnimalAssets.blobfish,
      package: "core",
      height: 128,
    );
  }
}
