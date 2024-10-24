import '../app_module.dart';
import 'noticeable_app_start_app_module.dart';

mixin WaitingAppStartAppModule on AppModule {
  /// Called when the app is started and all modules are initialized.
  ///
  /// The app calls [onAppStartWaiting] and waites for all calls to return before actually starting.
  ///
  /// If you have no fundamental app logic, but just want to get noticed when the app is starting,
  /// consider using [NoticeableAppStartAppModule].
  Future onAppStartWaiting();
}
