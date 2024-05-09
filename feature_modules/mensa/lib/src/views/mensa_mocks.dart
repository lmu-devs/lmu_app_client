import 'package:mensa/src/repository/api/api.dart';

class MensaMocks {
  MensaMocks._();

  static const openingHours = MensaOpeningHours(
    dayAsEnum: Weekday.monday,
    openingHours: ["8-12"],
  );

  static const mensaEntries = [
    MensaEntry(
      name: "Leopold",
      type: MensaType.mensa,
      distance: 23,
      isFavorite: true,
      openingHours: openingHours,
    ),
    MensaEntry(
      name: "Schelling",
      type: MensaType.bistro,
      distance: 50,
      isFavorite: false,
      openingHours: openingHours,
    )
  ];

  static var mensaDays = [
    MensaDay(
      time: DateTime.now(),
      mensaEntries: mensaEntries,
    ),
    MensaDay(
      time: DateTime.now().add(const Duration(days: 1)),
      mensaEntries: mensaEntries,
    ),
    MensaDay(
      time: DateTime.now().add(const Duration(days: 2)),
      mensaEntries: mensaEntries,
    ),
    MensaDay(
      time: DateTime.now().add(const Duration(days: 3)),
      mensaEntries: mensaEntries,
    ),
    MensaDay(
      time: DateTime.now().add(const Duration(days: 4)),
      mensaEntries: mensaEntries,
    ),
    MensaDay(
      time: DateTime.now().add(const Duration(days: 5)),
      mensaEntries: mensaEntries,
    ),
    MensaDay(
      time: DateTime.now().add(const Duration(days: 6)),
      mensaEntries: mensaEntries,
    ),
    MensaDay(
      time: DateTime.now().add(const Duration(days: 7)),
      mensaEntries: mensaEntries,
    ),
    MensaDay(
      time: DateTime.now().add(const Duration(days: 8)),
      mensaEntries: mensaEntries,
    ),
    MensaDay(
      time: DateTime.now().add(const Duration(days: 9)),
      mensaEntries: mensaEntries,
    ),
    MensaDay(
      time: DateTime.now().add(const Duration(days: 10)),
      mensaEntries: mensaEntries,
    ),
    MensaDay(
      time: DateTime.now().add(const Duration(days: 11)),
      mensaEntries: mensaEntries,
    ),
    MensaDay(
      time: DateTime.now().add(const Duration(days: 12)),
      mensaEntries: mensaEntries,
    ),
    MensaDay(
      time: DateTime.now().add(const Duration(days: 13)),
      mensaEntries: mensaEntries,
    ),
    MensaDay(
      time: DateTime.now().add(const Duration(days: 14)),
      mensaEntries: mensaEntries,
    ),
  ];

  static var mensaOverview = MensaOverview(mensaDays: mensaDays);
}