import 'package:core_routes/launch_flow.dart';
import 'package:flutter/widgets.dart';

import '../../../presentation/view/app_update_page.dart';
import '../../../presentation/view/faculty_selection_page.dart';
import '../../../presentation/view/release_notes_page.dart';
import '../../../presentation/view/welcome_page.dart';

class LaunchFlowRouterImpl extends LaunchFlowRouter {
  @override
  Widget buildAppUpdate(BuildContext context) => const AppUpdatePage();

  @override
  Widget buildWelcome(BuildContext context) => WelcomePage();

  @override
  Widget buildReleaseNotes(BuildContext context) => ReleaseNotesPage();

  @override
  Widget buildFacultySelection(BuildContext context) => FacultySelectionPage();
}
