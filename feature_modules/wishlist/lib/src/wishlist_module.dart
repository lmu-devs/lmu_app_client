import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/user.dart';
import 'bloc/wishlist_cubit.dart';
import 'repository/api/wishlist_api_client.dart';
import 'repository/wishlist_repository.dart';
import 'services/services.dart';

class WishlistModule extends AppModule
    with LocalDependenciesProvidingAppModule, WaitingAppStartAppModule, PrivateDataContainingAppModule {
  @override
  String get moduleName => 'WishlistModule';

  @override
  void provideLocalDependencies() {
    GetIt.I.registerSingleton<WishlistRepository>(
      ConnectedWishlistRepository(
        wishlistApiClient: WishlistApiClient(),
        userService: GetIt.I.get<UserService>(),
      ),
    );

    GetIt.I.registerSingleton<WishlistCubit>(WishlistCubit());
    GetIt.I.registerSingleton<WishlistUserPreferenceService>(WishlistUserPreferenceService());
  }

  @override
  Future onAppStartWaiting() async {
    await GetIt.I.get<WishlistUserPreferenceService>().init();
    await GetIt.I.get<WishlistCubit>().loadWishlistEntries();
  }

  @override
  void onDeletePrivateData() {
    GetIt.I.get<WishlistUserPreferenceService>().reset();
  }
}
