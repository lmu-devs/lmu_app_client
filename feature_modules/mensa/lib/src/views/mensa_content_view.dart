import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const MensaHeader(),
        Center(
          child: Text(mensaData),
        ),
        JoyText.body(
          "234234",
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => {
                Provider.of<ThemeProvider>(context, listen: false).setThemeMode(ThemeMode.light) // For dark theme
              },
              child: const Text('Light'),
            ),
            ElevatedButton(
              onPressed: () => {
                Provider.of<ThemeProvider>(context, listen: false).setThemeMode(ThemeMode.dark) // For light theme
              },
              child: const Text('Dark'),
            ),
            ElevatedButton(
              onPressed: () => {
                Provider.of<ThemeProvider>(context, listen: false).setThemeMode(ThemeMode.system) // For system theme
              },
              child: const Text('System'),
            ),
          ],
        ),
        JoyButton(
          onPressed: () => {VibrationPatterns.vibrate(VibrationType.success)},
          text: 'This is the Text yo',
          type: ElementType.primary,
        ),
        JoyButton(
          onPressed: () => {VibrationPatterns.vibrate(VibrationType.error)},
          text: 'This is the Text yo',
          type: ElementType.secondary,
          size: ElementSize.large,
        ),
      ],
    );
  }
}
