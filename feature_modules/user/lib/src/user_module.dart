import 'package:core/api.dart';
import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/user.dart';

import 'bloc/user_api_key/cubit.dart';
import 'repository/repository.dart';
import 'services/default_user_service.dart';

class UserModule extends AppModule with PriorityDependenciesProvidingAppModule {
  @override
  String get moduleName => 'UserModule';

  @override
  Future<void> providePriorityDependencies() async {
    GetIt.I.registerSingleton<UserRepository>(ConnectedUserRepository(userApi: UserApiClient()));
    GetIt.I.registerSingleton<UserApiKeyBloc>(UserApiKeyBloc());
    GetIt.I.registerSingleton<UserService>(DefaultUserService());

    final bloc = GetIt.I.get<UserApiKeyBloc>();
    bloc.add(CreateUserApiKey());
    await bloc.stream.firstWhere((state) => state is UserApiKeyLoadSuccess || state is UserApiKeyLoadFailure);
    final blocState = bloc.state;
    if (blocState is UserApiKeyLoadSuccess) {
      GetIt.I.get<BaseApiClient>().userApiKey = blocState.apiKey;
    }
  }
}
