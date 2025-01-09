import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'bloc/home_cubit.dart';
import 'repository/api/home_api_client.dart';
import 'repository/repository.dart';

class HomeModule extends AppModule with LocalDependenciesProvidingAppModule, NoticeableAppStartAppModule {
  @override
  String get moduleName => 'HomeModule';

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<HomeRepository>(
      ConnectedHomeRepository(
        homeApiClient: HomeApiClient(),
      ),
    );
    GetIt.I.registerSingleton<HomeCubit>(
      HomeCubit(homeRepository: GetIt.I.get<HomeRepository>()),
    );
  }

  @override
  void onAppStartNotice() {
    GetIt.I.get<HomeCubit>().loadHomeData();
  }
}