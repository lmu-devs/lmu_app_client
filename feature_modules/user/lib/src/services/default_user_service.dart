import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:shared_api/user.dart';

import '../bloc/user_api_key/cubit.dart';

class DefaultUserService extends UserService {
  final _userApiKeyBloc = GetIt.I.get<UserApiKeyBloc>();

  @override
  Stream<String?> get userApiKeyStream => _userApiKeyBloc.stream.map(
        (state) {
          if (state is UserApiKeyLoadSuccess) return state.apiKey;

          return null;
        },
      );

  @override
  String? get userApiKey {
    final state = _userApiKeyBloc.state;
    if (state is UserApiKeyLoadSuccess) return state.apiKey;
    return null;
  }

  @override
  bool get hasUserApiKey => _userApiKeyBloc.state is UserApiKeyLoadSuccess;

  @override
  Future<bool> deleteUserApiKey() async {
    final completer = Completer<bool>();

    _userApiKeyBloc.add(DeleteUserApiKey());

    final subscription = _userApiKeyBloc.stream.listen((state) {
      if (state is UserApiKeyDeleteFailure) {
        completer.complete(false);
      } else if (state is UserApiKeyDeleteSuccess) {
        completer.complete(true);
      }
    });

    try {
      return await completer.future;
    } finally {
      await subscription.cancel();
    }
  }

  /// For deleting private data, use the [PrivateDataContainingAppModule] instead.
  @override
  Stream<void> get deletePrivateDataStream => _userApiKeyBloc.stream.where(
        (state) => state is UserApiKeyDeleteSuccess,
      );
}
