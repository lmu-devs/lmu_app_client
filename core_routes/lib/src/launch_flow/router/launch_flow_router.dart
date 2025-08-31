import 'package:flutter/widgets.dart';

abstract class LaunchFlowRouter {
  Widget buildWelcome(BuildContext context);

  Widget buildAppUpdate(BuildContext context);

  Widget buildReleaseNotes(BuildContext context);

  Widget buildFacultySelection(BuildContext context);

  Widget buildPermissionsOnboarding(BuildContext context);
}
