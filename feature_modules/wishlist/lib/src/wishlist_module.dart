import 'package:core/module.dart';
import 'package:core_routes/wishlist.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/wishlist.dart';

import 'bloc/wishlist_cubit.dart';
import 'repository/api/wishlist_api_client.dart';
import 'repository/wishlist_repository.dart';
import 'routes/wishlist_router.dart';
import 'services/services.dart';

class WishlistModule extends AppModule
    with
        LocalDependenciesProvidingAppModule,
        NoticeableAppStartAppModule,
        PrivateDataContainingAppModule,
        PublicApiProvidingAppModule {
  @override
  String get moduleName => 'WishlistModule';

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<WishlistRepository>(
      ConnectedWishlistRepository(wishlistApiClient: WishlistApiClient()),
    );

    GetIt.I.registerSingleton<WishlistCubit>(WishlistCubit());
    GetIt.I.registerSingleton<WishlistUserPreferenceService>(WishlistUserPreferenceService());
  }

  @override
  void onAppStartNotice() {
    GetIt.I.get<WishlistUserPreferenceService>().init();
  }

  @override
  void onDeletePrivateData() {
    GetIt.I.get<WishlistUserPreferenceService>().reset();
  }

  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<WishlistService>(DefaultWishlistService());
    GetIt.I.registerSingleton<WishlistRouter>(WishlistRouterImpl());
  }
}
