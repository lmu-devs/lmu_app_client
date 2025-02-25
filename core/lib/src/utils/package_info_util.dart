import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoUtil {
  Future<String> getAppName() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.appName;
  }

  Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
