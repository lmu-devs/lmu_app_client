import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SettingsAnalyticsPage extends StatelessWidget {
  const SettingsAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final analyticsUserPreferenceService = GetIt.I<AnalyticsUserPreferenceService>();

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: "Analytics",
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: LmuSizes.size_16,
        ),
        child: Column(
          children: [
            const SizedBox(height: LmuSizes.size_16),
            LmuContentTile(
              content: ValueListenableBuilder<bool>(
                valueListenable: analyticsUserPreferenceService.isAnalyticsEnabled,
                builder: (context, isEnabled, child) => LmuListItem.action(
                  title: context.locals.settings.analyticsSwitch,
                  actionType: LmuListItemAction.toggle,
                  initialValue: isEnabled,
                  onChange: (value) {
                    LmuVibrations.secondary();
                    final analytics = GetIt.I<AnalyticsClient>();
                    analytics.toggleAnalyticsCollection(isEnabled: value);
                    analyticsUserPreferenceService.toggleAnalytics(value);
                  },
                ),
              ),
            ),
            const SizedBox(height: LmuSizes.size_16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LmuText.bodyXSmall(
                    context.locals.settings.analyticsDescription,
                    color:
                        context.colors.neutralColors.textColors.weakColors.base,
                  ),
                  const SizedBox(height: LmuSizes.size_8),
                  Text.rich(
                    TextSpan(
                      text: context.locals.settings.analyticsLink,
                      style:
                          LmuText.bodyXSmall('').getTextStyle(context).copyWith(
                                color: context.colors.neutralColors.textColors
                                    .weakColors.base,
                              ),
                      children: [
                        TextSpan(
                          text: context.locals.launchFlow.dataPrivacyLabel,
                          style: LmuText.bodyXSmall('')
                              .getTextStyle(context)
                              .copyWith(
                                color: context.colors.neutralColors.textColors
                                    .strongColors.base,
                                fontWeight: FontWeight.w400,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
