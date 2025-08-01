import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:shared_api/explore.dart';

extension ExploreMarkerTypeStyling on ExploreMarkerType {
  Color markerColor(LmuColors colors) {
    return switch (this) {
      ExploreMarkerType.mensaMensa => colors.customColors.colorColors.green,
      ExploreMarkerType.mensaStuBistro => colors.customColors.colorColors.pink,
      ExploreMarkerType.mensaStuCafe => colors.customColors.colorColors.amber,
      ExploreMarkerType.mensaStuLounge => colors.customColors.colorColors.stuLounge,
      ExploreMarkerType.cinema => colors.customColors.colorColors.red,
      ExploreMarkerType.roomfinderBuilding => colors.customColors.colorColors.blue,
      ExploreMarkerType.library => colors.customColors.colorColors.purple,
    };
  }

  String localizedName(LmuLocalizations localizations) {
    return switch (this) {
      ExploreMarkerType.mensaMensa => localizations.canteen.mensaTypeMensa,
      ExploreMarkerType.mensaStuBistro => localizations.canteen.mensaTypeStuBistro,
      ExploreMarkerType.mensaStuCafe => localizations.canteen.mensaTypeStuCafe,
      ExploreMarkerType.mensaStuLounge => localizations.canteen.mensaTypeCafeBar,
      ExploreMarkerType.cinema => localizations.cinema.cinema,
      ExploreMarkerType.roomfinderBuilding => localizations.roomfinder.building,
      ExploreMarkerType.library => localizations.libraries.library,
    };
  }

  IconData get icon {
    return switch (this) {
      ExploreMarkerType.mensaMensa => LucideIcons.utensils,
      ExploreMarkerType.mensaStuBistro => LucideIcons.utensils,
      ExploreMarkerType.mensaStuCafe => LucideIcons.utensils,
      ExploreMarkerType.mensaStuLounge => LucideIcons.coffee,
      ExploreMarkerType.cinema => LucideIcons.clapperboard,
      ExploreMarkerType.roomfinderBuilding => LucideIcons.school,
      ExploreMarkerType.library => LucideIcons.library_big,
    };
  }
}
