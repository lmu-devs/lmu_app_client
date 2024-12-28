import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/user.dart';
import 'package:wishlist/src/util/wishlist_notifier.dart';
import 'bloc/wishlist_cubit.dart';
import 'bloc/wishlist_state.dart';
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
      userService: GetIt.I.get<UserService>(),
    );

    final wishlistNotifier = WishlistNotifier([]);

    GetIt.I.registerSingleton<WishlistRepository>(
      repository,
    );
    GetIt.I.registerSingleton<WishlistCubit>(
      WishlistCubit(wishlistRepository: repository),
    );
    GetIt.I.registerSingleton<WishlistNotifier>(
      wishlistNotifier,
    );
  }

  @override
  void providePublicApi() {}

  @override
  void onAppStartNotice() {
    final wishlistCubit = GetIt.I.get<WishlistCubit>();
    final wishlistNotifier = GetIt.I.get<WishlistNotifier>();

    wishlistCubit.loadWishlistEntries().then((_) {
      if (wishlistCubit.state is WishlistLoadSuccess) {
        final entries = (wishlistCubit.state as WishlistLoadSuccess).wishlistModels;
        wishlistNotifier.updateWishlistModels(entries);
      }
    });
  }
}
