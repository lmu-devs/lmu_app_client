import 'api/mensa_api_client.dart';

abstract class MensaRepository {
  Future<String> getMensa();
}

class ConnectedMensaRepository implements MensaRepository {
  ConnectedMensaRepository({
    required this.mensaApiClient,
  });

  final MensaApiClient mensaApiClient;

  @override
  Future<String> getMensa() {
    return mensaApiClient.getMensa();
  }
}
