import '../app_module.dart';
import 'waiting_app_start_app_module.dart';

mixin NoticeableAppStartAppModule on AppModule {
  /// Called when the app is started and all modules are initialized.
  ///
  /// The app calls [onAppStartNotice] but does not wait for it to complete.
  ///
  /// If you have fundamental app logic which should be completed before the app is actually starting,
  /// consider using [WaitingAppStartAppModule].
  void onAppStartNotice();
}
