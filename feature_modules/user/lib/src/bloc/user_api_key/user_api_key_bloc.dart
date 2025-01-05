import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/user_repository.dart';
import 'user_api_key_event.dart';
import 'user_api_key_state.dart';

class UserApiKeyBloc extends Bloc<UserApiKeyEvent, UserApiKeyState> {
  UserApiKeyBloc() : super(UserApiKeyInitial()) {
    on<CreateUserApiKey>(_onCreateUserApiKey);
    on<DeleteUserApiKey>(_onDeleteUserApiKey);
  }

  final _repository = GetIt.I.get<UserRepository>();

  Future<void> _onCreateUserApiKey(
    CreateUserApiKey event,
    Emitter<UserApiKeyState> emit,
  ) async {
    emit(UserApiKeyLoadInProgress());

    try {
      final apiKey = await _repository.getUser();

      if (apiKey != null) {
        emit(UserApiKeyLoadSuccess(apiKey: apiKey));
        return;
      }

      final newUserApiKey = await _repository.createUser();
      emit(UserApiKeyLoadSuccess(apiKey: newUserApiKey));
    } catch (e) {
      emit(UserApiKeyLoadFailure());
    }
  }

  Future<void> _onDeleteUserApiKey(
    DeleteUserApiKey event,
    Emitter<UserApiKeyState> emit,
  ) async {
    final currentState = state;
    if (currentState is! UserApiKeyLoadSuccess) return;
    final apiKey = currentState.apiKey;
    emit(UserApiKeyDeleteInProgress(apiKey: apiKey));

    try {
      await _repository.deleteUser(apiKey);
      emit(UserApiKeyDeleteSuccess());
      add(CreateUserApiKey());
    } catch (e) {
      emit(UserApiKeyDeleteFailure(apiKey: apiKey));
    }
  }
}
