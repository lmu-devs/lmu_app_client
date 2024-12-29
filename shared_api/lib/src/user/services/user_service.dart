abstract class UserService {
  Stream<String?> get userApiKeyStream;

  String? get userApiKey;

  bool get hasUserApiKey;

  Future<bool> deleteUserApiKey();

  Stream<void> get deletePrivateDataStream;
}
