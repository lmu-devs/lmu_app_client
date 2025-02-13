import '../../../explore.dart';

abstract class MensaService {
  Stream<List<ExploreLocation>> get mensaExploreLocationsStream;
}
