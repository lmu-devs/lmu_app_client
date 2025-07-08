import 'package:flutter/widgets.dart';

abstract class SettingsRouter {
  Widget buildMain(BuildContext context);

  Widget buildAppearance(BuildContext context);

  Widget buildAccount(BuildContext context);

  Widget buildLanguage(BuildContext context);

  Widget buildAnalytics(BuildContext context);

  Widget buildNotifications(BuildContext context);

  Widget buildLicense(BuildContext context);

  Widget buildDebug(BuildContext context);

  Widget buildSafari(BuildContext context);
}
