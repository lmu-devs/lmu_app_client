import 'package:core_routes/settings.dart';
import 'package:flutter/widgets.dart';

import '../pages/pages.dart';

class SettingsRouterImpl extends SettingsRouter {
  @override
  Widget buildMain(BuildContext context) => const SettingsMainPage();

  @override
  Widget buildAccount(BuildContext context) => const SettingsAccountPage();

  @override
  Widget buildAppearance(BuildContext context) => const SettingsAppearancePage();

  @override
  Widget buildDebug(BuildContext context) => const SettingsDebugPage();

  @override
  Widget buildLanguage(BuildContext context) => const SettingsLanguagePage();

  @override
  Widget buildAnalytics(BuildContext context) => const SettingsAnalyticsPage();

  @override
  Widget buildLicense(BuildContext context) => const SettingsLicencePage();

  @override
  Widget buildSafari(BuildContext context) => SettingsSafariPage();
}
