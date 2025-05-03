import 'package:core/module.dart';
import 'package:core_routes/timeline.dart';
import 'package:get_it/get_it.dart';

import 'cubit/timeline_cubit/cubit.dart';
import 'repository/api/timeline_api_client.dart';
import 'repository/timeline_repository.dart';
import 'routes/timeline_router.dart';

class TimelineModule extends AppModule with LocalDependenciesProvidingAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'TimelineModule';

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<TimelineRouter>(TimelineRouterImpl());
  }

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<TimelineApiClient>(TimelineApiClient());
    GetIt.I.registerSingleton<TimelineRepository>(ConnectedTimelineRepository());
    GetIt.I.registerSingleton<TimelineCubit>(TimelineCubit());
  }
}
