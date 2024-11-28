import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../themes.dart';

String getPngAssetTheme(BuildContext context, String asset) {
  if (Provider.of<ThemeProvider>(context, listen: false).themeMode == ThemeMode.light) {
    return '${asset}_light.png';
  } else if (Provider.of<ThemeProvider>(context, listen: false).themeMode == ThemeMode.dark) {
    return '${asset}_dark.png';
  } else {
    return MediaQuery.of(context).platformBrightness == Brightness.light ? '${asset}_light.png' : '${asset}_dark.png';
  }
}
