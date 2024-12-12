import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'bloc/wishlist_cubit.dart';
import 'repository/api/wishlist_api_client.dart';
import 'repository/wishlist_repository.dart';

class WishlistModule extends AppModule
    with LocalDependenciesProvidingAppModule, NoticeableAppStartAppModule, PublicApiProvidingAppModule {
  @override
  String get moduleName => 'WishlistModule';

  @override
  void provideLocalDependencies() {
    final repository = ConnectedWishlistRepository(
      wishlistApiClient: WishlistApiClient(),
    );

    GetIt.I.registerSingleton<WishlistRepository>(
      repository,
    );
    GetIt.I.registerSingleton<WishlistCubit>(
      WishlistCubit(wishlistRepository: repository),
    );
  }

  @override
  void providePublicApi() {}

  @override
  void onAppStartNotice() {
    GetIt.I.get<WishlistCubit>().loadWishlistEntries();
  }
}
