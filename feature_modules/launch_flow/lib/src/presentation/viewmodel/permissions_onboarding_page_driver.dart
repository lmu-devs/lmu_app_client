import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/launch_flow.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/interface/launch_flow_repository_interface.dart';

part 'permissions_onboarding_page_driver.g.dart';

@GenerateTestDriver()
class PermissionsOnboardingPageDriver extends WidgetDriver {
  late LaunchFlowLocatizations _flowLocalizations;
  late BuildContext _navigatorContext;

  String get permissionsTitle => _flowLocalizations.permissionsOnboardingTitle;

  String get permissionsDescription => _flowLocalizations.permissionsOnboardingDescription;

  String get doneButtonText => _flowLocalizations.permissionsOnboardingButton;

  String get skipButtonText => _flowLocalizations.permissionsOnboardingSkip;

  void onDonePressed() async {
   await GetIt.I<PushNotificationsClient>().requestPermission();
   await GetIt.I<NotificationsUserPreferenceService>().refreshStatus();
    _navigateToNextPage();
  }

  void onSkipPressed() {
    _navigateToNextPage();
  }

  void _navigateToNextPage() {
    GetIt.I.get<LaunchFlowRepositoryInterface>().showedPermissionsOnboardingPage();
    final launchFlowApi = GetIt.I.get<LaunchFlowApi>();
    launchFlowApi.continueFlow(_navigatorContext);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _flowLocalizations = context.locals.launchFlow;
    _navigatorContext = context;
  }
}
