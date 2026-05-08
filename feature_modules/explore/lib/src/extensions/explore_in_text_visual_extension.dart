import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_api/explore.dart';

extension ExploreInTextVisualExtension on ExploreMarkerType {
  Color backgroundColor(LmuColors colors) {
    return switch (this) {
      ExploreMarkerType.mensaMensa => colors.customColors.backgroundColors.green,
      ExploreMarkerType.mensaStuBistro => colors.customColors.backgroundColors.pink,
      ExploreMarkerType.mensaStuCafe => colors.customColors.backgroundColors.amber,
      ExploreMarkerType.mensaStuLounge => colors.customColors.backgroundColors.stuLounge,
      ExploreMarkerType.cinema => colors.customColors.backgroundColors.red,
      ExploreMarkerType.roomfinderBuilding => colors.customColors.backgroundColors.blue,
      ExploreMarkerType.library => colors.customColors.backgroundColors.purple,
    };
  }

  Color textColor(LmuColors colors) {
    return switch (this) {
      ExploreMarkerType.mensaMensa => colors.customColors.textColors.green,
      ExploreMarkerType.mensaStuBistro => colors.customColors.textColors.pink,
      ExploreMarkerType.mensaStuCafe => colors.customColors.textColors.amber,
      ExploreMarkerType.mensaStuLounge => colors.customColors.textColors.stuLounge,
      ExploreMarkerType.cinema => colors.customColors.textColors.red,
      ExploreMarkerType.roomfinderBuilding => colors.customColors.textColors.blue,
      ExploreMarkerType.library => colors.customColors.textColors.purple,
    };
  }
}
