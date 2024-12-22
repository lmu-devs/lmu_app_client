import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/user.dart';

import 'bloc/user_api_key/cubit.dart';
import 'repository/repository.dart';
import 'services/default_user_service.dart';

class UserModule extends AppModule
    with PublicApiProvidingAppModule, WaitingAppStartAppModule, LocalDependenciesProvidingAppModule {
  @override
  String get moduleName => 'UserModule';

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<UserRepository>(ConnectedUserRepository(userApi: UserApiClient()));
    GetIt.I.registerSingleton<UserApiKeyBloc>(UserApiKeyBloc());
    GetIt.I.registerSingleton<UserService>(DefaultUserService());
  }

  @override
  void providePublicApi() {
    //GetIt.I.registerSingleton<UserService>(DefaultUserService());
  }

  @override
  Future onAppStartWaiting() async {
    final bloc = GetIt.I.get<UserApiKeyBloc>();
    bloc.add(CreateUserApiKey());
    await bloc.stream.firstWhere((state) => state is UserApiKeyLoadSuccess || state is UserApiKeyLoadFailure);
  }
}
