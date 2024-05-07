import 'package:http/http.dart' as http;

class MensaApiClient {
  Future<String> getMensa() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/mensadata'),
      );

      final body = response.body;

      return body;
    } catch (e) {
      throw Error();
    }
  }
}
