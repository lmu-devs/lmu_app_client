import 'mensa_location.dart';
import 'mensa_opening_hours.dart';

class MensaDetails {
  MensaDetails({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
    required this.canteenId,
    required this.openingHours,
  });

  final String id;
  final String name;
  final String address;
  final MensaLocation location;
  final String canteenId;
  final MensaOpeningHours openingHours;
}
