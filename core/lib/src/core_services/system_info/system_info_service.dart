import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SystemInfo {
  const SystemInfo({
    required this.appName,
    required this.appVersion,
    required this.systemVersion,
  });

  final String appName;
  final String appVersion;
  final String systemVersion;
}

class SystemInfoService {
  late final SystemInfo _systemInfo;

  bool _initialized = false;

  Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();

    final systemVersion = await _getOSVersion();

    _systemInfo = SystemInfo(
      appName: packageInfo.appName,
      appVersion: packageInfo.version,
      systemVersion: systemVersion,
    );

    _initialized = true;
  }

  SystemInfo get systemInfo {
    if (!_initialized) throw StateError('SystemInfoService not initialized. Call init() first.');
    return _systemInfo;
  }

  Future<String> _getOSVersion() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return 'Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return 'iOS ${iosInfo.systemVersion}';
    } else {
      return 'Unknown Platform';
    }
  }
}
