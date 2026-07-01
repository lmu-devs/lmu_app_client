import 'package:core/localizations.dart';

enum ClubType {
  fachschaft,
  hochschulgruppe,
  referat,
  verein,
  institution,
}

extension ClubTypeExtension on ClubType {
  String localizedName(ClubsLocalizations localizations) {
    return switch (this) {
      ClubType.fachschaft => localizations.typeFachschaft,
      ClubType.hochschulgruppe => localizations.typeHochschulgruppe,
      ClubType.referat => localizations.typeReferat,
      ClubType.verein => localizations.typeVerein,
      ClubType.institution => localizations.typeInstitution,
    };
  }
}
