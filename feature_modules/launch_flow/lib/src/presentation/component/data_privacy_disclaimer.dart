import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class DataPrivacyDisclaimer extends StatelessWidget {
  const DataPrivacyDisclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    final neutralColors = context.colors.neutralColors;
    final flowLocalizations = context.locals.launchFlow;

    return Text.rich(
      TextSpan(
        text: flowLocalizations.dataPrivacyIntro,
        style: LmuText.bodySmall('').getTextStyle(context).copyWith(
              color: neutralColors.textColors.mediumColors.base,
            ),
        children: [
          TextSpan(
            text: flowLocalizations.dataPrivacyLabel,
            style: LmuText.bodySmall('').getTextStyle(context).copyWith(
                  color: neutralColors.textColors.mediumColors.base,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  decorationColor: neutralColors.textColors.mediumColors.base,
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                LmuUrlLauncher.launchWebsite(
                  url: LmuDevStrings.lmuDevDataPrivacy,
                  context: context,
                );
              },
          ),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
