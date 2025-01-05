import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:home/src/bloc/home_cubit.dart';
import 'package:home/src/repository/api/home_api_client.dart';
import 'package:home/src/repository/repository.dart';

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