import 'package:core/components.dart';
import 'package:core_routes/config.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/launch_flow.dart';

class LmuRouterConfig {
  static final GoRouter router = GoRouter(
    routes: $appRoutes,
    initialLocation: GetIt.I.get<LaunchFlowApi>().initialLocation,
    errorBuilder: (context, state) {
      return Lmu404Page(exception: state.error);
    },
  );
}
