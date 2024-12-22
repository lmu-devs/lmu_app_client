import 'package:get_it/get_it.dart';
import 'package:shared_api/user.dart';

import '../bloc/user_api_key/cubit.dart';

class DefaultUserService extends UserService {
  DefaultUserService() {
    userApiKeyStream.listen((event) {
      if (event != null) {
        print('UserApiKey: $event');
      }
    });
  }
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
}
