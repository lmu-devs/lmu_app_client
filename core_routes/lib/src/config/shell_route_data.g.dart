// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shell_route_data.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $shellRouteData,
    ];

RouteBase get $shellRouteData => StatefulShellRouteData.$route(
      restorationScopeId: ShellRouteData.$restorationScopeId,
      navigatorContainerBuilder: ShellRouteData.$navigatorContainerBuilder,
      factory: $ShellRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/home',
              factory: $HomeMainRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'settings',
                  factory: $SettingsMainRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'appearance',
                      factory: $SettingsApperanceRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'language',
                      factory: $SettingsLanguageRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'license',
                      factory: $SettingsLicenceRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'account',
                      factory: $SettingsAccountRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'debug',
                      factory: $SettingsDebugRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'links',
                  factory: $LinksRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'search',
                      factory: $LinksSearchRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'benefits',
                  factory: $BenefitsRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'timeline',
                  factory: $TimelineMainRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'sports',
                  factory: $SportsMainRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'details',
                      factory: $SportsDetailsRouteExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'search',
                      factory: $SportsSearchRouteExtension._fromState,
                      routes: [
                        GoRouteData.$route(
                          path: 'details',
                          factory: $SportsSearchDetailsRouteExtension._fromState,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/mensa',
              factory: $MensaMainRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'details',
                  factory: $MensaDetailsRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'search',
                  factory: $MensaSearchRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'details',
                      factory: $MensaSearchDetailsRouteExtension._fromState,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/explore',
              factory: $ExploreMainRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'search',
                  factory: $ExploreSearchRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/wishlist',
              factory: $WishlistMainRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'details',
                  factory: $WishlistDetailsRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $ShellRouteDataExtension on ShellRouteData {
  static ShellRouteData _fromState(GoRouterState state) => const ShellRouteData();
}

extension $HomeMainRouteExtension on HomeMainRoute {
  static HomeMainRoute _fromState(GoRouterState state) => const HomeMainRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsMainRouteExtension on SettingsMainRoute {
  static SettingsMainRoute _fromState(GoRouterState state) => const SettingsMainRoute();

  String get location => GoRouteData.$location(
        '/home/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsApperanceRouteExtension on SettingsApperanceRoute {
  static SettingsApperanceRoute _fromState(GoRouterState state) => const SettingsApperanceRoute();

  String get location => GoRouteData.$location(
        '/home/settings/appearance',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsLanguageRouteExtension on SettingsLanguageRoute {
  static SettingsLanguageRoute _fromState(GoRouterState state) => const SettingsLanguageRoute();

  String get location => GoRouteData.$location(
        '/home/settings/language',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsLicenceRouteExtension on SettingsLicenceRoute {
  static SettingsLicenceRoute _fromState(GoRouterState state) => const SettingsLicenceRoute();

  String get location => GoRouteData.$location(
        '/home/settings/license',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsAccountRouteExtension on SettingsAccountRoute {
  static SettingsAccountRoute _fromState(GoRouterState state) => const SettingsAccountRoute();

  String get location => GoRouteData.$location(
        '/home/settings/account',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsDebugRouteExtension on SettingsDebugRoute {
  static SettingsDebugRoute _fromState(GoRouterState state) => const SettingsDebugRoute();

  String get location => GoRouteData.$location(
        '/home/settings/debug',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LinksRouteExtension on LinksRoute {
  static LinksRoute _fromState(GoRouterState state) => const LinksRoute();

  String get location => GoRouteData.$location(
        '/home/links',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LinksSearchRouteExtension on LinksSearchRoute {
  static LinksSearchRoute _fromState(GoRouterState state) => const LinksSearchRoute();

  String get location => GoRouteData.$location(
        '/home/links/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BenefitsRouteExtension on BenefitsRoute {
  static BenefitsRoute _fromState(GoRouterState state) => const BenefitsRoute();

  String get location => GoRouteData.$location(
        '/home/benefits',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TimelineMainRouteExtension on TimelineMainRoute {
  static TimelineMainRoute _fromState(GoRouterState state) => const TimelineMainRoute();

  String get location => GoRouteData.$location(
        '/home/timeline',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SportsMainRouteExtension on SportsMainRoute {
  static SportsMainRoute _fromState(GoRouterState state) => const SportsMainRoute();

  String get location => GoRouteData.$location(
        '/home/sports',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SportsDetailsRouteExtension on SportsDetailsRoute {
  static SportsDetailsRoute _fromState(GoRouterState state) => SportsDetailsRoute(
        state.extra as RSportsType,
      );

  String get location => GoRouteData.$location(
        '/home/sports/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $SportsSearchRouteExtension on SportsSearchRoute {
  static SportsSearchRoute _fromState(GoRouterState state) => const SportsSearchRoute();

  String get location => GoRouteData.$location(
        '/home/sports/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SportsSearchDetailsRouteExtension on SportsSearchDetailsRoute {
  static SportsSearchDetailsRoute _fromState(GoRouterState state) => SportsSearchDetailsRoute(
        state.extra as RSportsType,
      );

  String get location => GoRouteData.$location(
        '/home/sports/search/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $MensaMainRouteExtension on MensaMainRoute {
  static MensaMainRoute _fromState(GoRouterState state) => const MensaMainRoute();

  String get location => GoRouteData.$location(
        '/mensa',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MensaDetailsRouteExtension on MensaDetailsRoute {
  static MensaDetailsRoute _fromState(GoRouterState state) => MensaDetailsRoute(
        state.extra as RMensaModel,
      );

  String get location => GoRouteData.$location(
        '/mensa/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $MensaSearchRouteExtension on MensaSearchRoute {
  static MensaSearchRoute _fromState(GoRouterState state) => const MensaSearchRoute();

  String get location => GoRouteData.$location(
        '/mensa/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MensaSearchDetailsRouteExtension on MensaSearchDetailsRoute {
  static MensaSearchDetailsRoute _fromState(GoRouterState state) => MensaSearchDetailsRoute(
        state.extra as RMensaModel,
      );

  String get location => GoRouteData.$location(
        '/mensa/search/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

extension $ExploreMainRouteExtension on ExploreMainRoute {
  static ExploreMainRoute _fromState(GoRouterState state) => const ExploreMainRoute();

  String get location => GoRouteData.$location(
        '/explore',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ExploreSearchRouteExtension on ExploreSearchRoute {
  static ExploreSearchRoute _fromState(GoRouterState state) => const ExploreSearchRoute();

  String get location => GoRouteData.$location(
        '/explore/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WishlistMainRouteExtension on WishlistMainRoute {
  static WishlistMainRoute _fromState(GoRouterState state) => const WishlistMainRoute();

  String get location => GoRouteData.$location(
        '/wishlist',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WishlistDetailsRouteExtension on WishlistDetailsRoute {
  static WishlistDetailsRoute _fromState(GoRouterState state) => WishlistDetailsRoute(
        state.extra as RWishlistModel,
      );

  String get location => GoRouteData.$location(
        '/wishlist/details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}
