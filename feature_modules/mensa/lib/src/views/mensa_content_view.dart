import 'package:core/interface/button/dev_button_models.dart';
import 'package:core/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:core/interface/interface.dart';

import '../widgets/mensa_header.dart';

class MensaContentView extends StatelessWidget {
  const MensaContentView({
    required this.mensaData,
    super.key,
  });

  final String mensaData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const MensaHeader(),
        Center(
          child: Text(mensaData),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => {
                Provider.of<ThemeProvider>(context, listen: false)
                    .setThemeMode(ThemeMode.light) // For dark theme
              },
              child: const Text('Light'),
            ),
            ElevatedButton(
              onPressed: () => {
                Provider.of<ThemeProvider>(context, listen: false)
                    .setThemeMode(ThemeMode.dark) // For light theme
              },
              child: const Text('Dark'),
            ),
            ElevatedButton(
              onPressed: () => {
                Provider.of<ThemeProvider>(context, listen: false)
                    .setThemeMode(ThemeMode.system) // For system theme
              },
              child: const Text('System'),
            ),
            DevButton(onPressed: () => {}, text: 'This is the Text yo', type: DevButtonType.PRIMARY,),
          ],
        ),
      ],
    );
  }
}
