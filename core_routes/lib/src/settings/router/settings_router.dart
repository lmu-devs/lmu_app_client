import 'package:flutter/widgets.dart';

abstract class SettingsRouter {
  Widget buildMain(BuildContext context);

  Widget buildApperance(BuildContext context);

  Widget buildAccount(BuildContext context);

  Widget buildLanguage(BuildContext context);

  Widget buildLicense(BuildContext context);

  Widget buildDebug(BuildContext context);
}
