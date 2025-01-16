import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../themes.dart';

String getPngAssetTheme(String asset) {
  final themeMode = GetIt.I.get<ThemeProvider>().themeMode;
  if (themeMode == ThemeMode.light) {
    return '${asset}_light.png';
  } else if (themeMode == ThemeMode.dark) {
    return '${asset}_dark.png';
  }
  return PlatformDispatcher.instance.platformBrightness == Brightness.light
      ? '${asset}_light.png'
      : '${asset}_dark.png';
}
