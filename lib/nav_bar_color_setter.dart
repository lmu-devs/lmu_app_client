import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class NavigationBarColorSetter extends StatelessWidget {
  const NavigationBarColorSetter({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
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