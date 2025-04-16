import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:shared_api/explore.dart';

extension ExploreMarkerTypeStyling on ExploreMarkerType {
  Color markerColor(LmuColors colors) {
    return switch (this) {
      ExploreMarkerType.mensaMensa => colors.mensaColors.textColors.mensa,
      ExploreMarkerType.mensaStuBistro => colors.mensaColors.textColors.stuBistro,
      ExploreMarkerType.mensaStuCafe => colors.mensaColors.textColors.stuCafe,
      ExploreMarkerType.mensaStuLounge => colors.mensaColors.textColors.stuLounge,
      ExploreMarkerType.cinema => const Color(0xFFD64444),
      ExploreMarkerType.roomfinderRoom => const Color(0xFF1A95F3),
    };
  }

  String localizedName(LmuLocalizations localizations) {
    return switch (this) {
      ExploreMarkerType.mensaMensa => localizations.canteen.mensaTypeMensa,
      ExploreMarkerType.mensaStuBistro => localizations.canteen.mensaTypeStuBistro,
      ExploreMarkerType.mensaStuCafe => localizations.canteen.mensaTypeStuCafe,
      ExploreMarkerType.mensaStuLounge => localizations.canteen.mensaTypeCafeBar,
      ExploreMarkerType.cinema => localizations.cinema.cinema,
      ExploreMarkerType.roomfinderRoom => localizations.roomfinder.building,
    };
  }

  IconData get icon {
    return switch (this) {
      ExploreMarkerType.mensaMensa => LucideIcons.utensils,
      ExploreMarkerType.mensaStuBistro => LucideIcons.utensils,
      ExploreMarkerType.mensaStuCafe => LucideIcons.utensils,
      ExploreMarkerType.mensaStuLounge => LucideIcons.coffee,
      ExploreMarkerType.cinema => LucideIcons.clapperboard,
      ExploreMarkerType.roomfinderRoom => LucideIcons.school,
    };
  }
}
