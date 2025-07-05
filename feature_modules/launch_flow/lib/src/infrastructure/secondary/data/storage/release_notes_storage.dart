import 'package:shared_preferences/shared_preferences.dart';

class ReleaseNotesStorage {
  final _launchFlowReleaseNotesKey = 'launch_flow_release_notes';

  Future<void> saveShowedReleaseNotes({required String version}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_launchFlowReleaseNotesKey$version';
    await prefs.setBool(key, false);
  }

  Future<bool> shouldShowReleaseNotes({required String version}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_launchFlowReleaseNotesKey$version';
    return prefs.getBool(key) ?? true;
  }
}
