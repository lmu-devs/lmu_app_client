import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

enum Rarity { common, rare, epic, legendary }

extension RarityEncouterProabilityExtension on Rarity {
  double get encounterProbability {
    return switch (this) {
      Rarity.common => 0.5,
      Rarity.rare => 0.15,
      Rarity.epic => 0.04,
      Rarity.legendary => 0.01,
    };
  }

  String toLocalizedString(DeveloperdexLocatizations locatizations) => switch (this) {
        Rarity.common => locatizations.common,
        Rarity.rare => locatizations.rare,
        Rarity.epic => locatizations.epic,
        Rarity.legendary => locatizations.legendary,
      };

  Color toBackgroundColor(LmuColors colors) => switch (this) {
        Rarity.common => colors.customColors.backgroundColors.green,
        Rarity.rare => colors.customColors.backgroundColors.blue,
        Rarity.epic => colors.customColors.backgroundColors.purple,
        Rarity.legendary => colors.customColors.backgroundColors.amber,
      };

  Color toTextColor(LmuColors colors) => switch (this) {
        Rarity.common => colors.customColors.textColors.green,
        Rarity.rare => colors.customColors.textColors.blue,
        Rarity.epic => colors.customColors.textColors.purple,
        Rarity.legendary => colors.customColors.textColors.amber,
      };
}
