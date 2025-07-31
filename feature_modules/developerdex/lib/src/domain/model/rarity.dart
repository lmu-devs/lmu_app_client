import 'package:core/localizations.dart';

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
}
