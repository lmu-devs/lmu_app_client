abstract class UserService {
  Stream<String?> get userApiKeyStream;

  String? get userApiKey;

  bool get hasUserApiKey;
}
