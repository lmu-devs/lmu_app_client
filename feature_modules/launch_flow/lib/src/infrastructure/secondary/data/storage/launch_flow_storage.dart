import 'package:shared_preferences/shared_preferences.dart';

class LaunchFlowStorage {
  final _launchFlowWelcomePageKey = 'launch_flow_showed_welcome_page_key';
  final _launchFlowFacultySelectionPageKey = 'launch_flow_showed_faculty_selection_page_key';
  final _launchFlowPermissionsOnboardingPageKey = 'launch_flow_showed_permissions_onboarding_page_key';

  Future<void> saveShowedWelcomePage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_launchFlowWelcomePageKey, false);
  }

  Future<bool?> getShowWelcomePage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_launchFlowWelcomePageKey);
  }

  Future<void> saveShowedFacultySelectionPage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_launchFlowFacultySelectionPageKey, false);
  }

  Future<bool?> getShowFacultySelectionPage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_launchFlowFacultySelectionPageKey);
  }

  Future<void> saveShowedPermissionsOnboardingPage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_launchFlowPermissionsOnboardingPageKey, false);
  }

  Future<bool?> getShowPermissionsOnboardingPage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_launchFlowPermissionsOnboardingPageKey);
  }
}
