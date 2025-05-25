import 'package:shared_preferences/shared_preferences.dart';

class LaunchFlowStorage {
  final _launchFlowKey = 'launch_flow_showed_welcome_page_key';

  Future<void> saveShowedWelcomePage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_launchFlowKey, false);
  }

  Future<bool?> getShowWelcomePage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_launchFlowKey);
  }
}
