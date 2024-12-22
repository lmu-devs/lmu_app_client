abstract class UserApiKeyEvent {}

class CreateUserApiKey extends UserApiKeyEvent {
  CreateUserApiKey();
}

class DeleteUserApiKey extends UserApiKeyEvent {
  DeleteUserApiKey();
}
