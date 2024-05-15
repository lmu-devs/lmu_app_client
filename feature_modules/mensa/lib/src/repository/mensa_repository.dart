import 'api/mensa_api_client.dart';
import 'api/models/mensa_model.dart';

abstract class MensaRepository {
  Future<List<MensaModel>> getMensaOverview();
}

class ConnectedMensaRepository implements MensaRepository {
  ConnectedMensaRepository({
    required this.mensaApiClient,
  });

  final MensaApiClient mensaApiClient;

  @override
  Future<List<MensaModel>> getMensaOverview() {
    return mensaApiClient.getMensaOverview();
  }
}
