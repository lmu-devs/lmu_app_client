import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This is required to set the NavBar Color to our Theme on Android Devices
class NavigationBarColorSetter extends StatelessWidget {
  const NavigationBarColorSetter({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final Color navBarColor = context.colors.neutralColors.backgroundColors.base;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: navBarColor,
        systemNavigationBarIconBrightness: brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      ),
    );

    return const SizedBox.shrink();
  }
}
