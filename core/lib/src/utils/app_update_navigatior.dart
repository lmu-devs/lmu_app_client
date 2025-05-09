import 'package:go_router/go_router.dart';

class AppUpdateNavigator {
  static late GoRouter router;

  static void popAllAndNavigate() => router.go('/app_update');
}
