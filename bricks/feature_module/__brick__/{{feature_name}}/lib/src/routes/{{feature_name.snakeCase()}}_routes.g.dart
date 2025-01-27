// GENERATED CODE - DO NOT MODIFY BY HAND

part of '{{feature_name.snakeCase()}}_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

RouteBase get ${{feature_name.snakeCase()}}MainRoute => GoRouteData.$route(
      path: '{{feature_name.snakeCase()}}',
      factory: ${{feature_name.pascalCase()}}MainRouteExtension._fromState,
      routes: [],
    );

extension ${{feature_name.pascalCase()}}MainRouteExtension on {{feature_name.pascalCase()}}MainRoute {
  static {{feature_name.pascalCase()}}MainRoute _fromState(GoRouterState state) => const  {{feature_name.pascalCase()}}MainRoute();

  String get location => GoRouteData.$location(
        '/{{feature_name.snakeCase()}}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
