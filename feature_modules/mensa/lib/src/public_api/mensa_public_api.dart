import '../repository/api/api.dart';
import 'models/mensa_location_data.dart';

abstract class MensaPublicApi {
  String get test;

  List<MensaLocationData> get testLocations;

  List<MensaModel> get mensaData;
}
