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
              content: ValueListenableBuilder<AnalyticsPreference>(
                valueListenable: analyticsUserPreferenceService.analyticsPreference,
                builder: (context, preference, child) {
                  final isEnabled = preference == AnalyticsPreference.enabled;
                  return LmuListItem.action(
                    title: context.locals.settings.analyticsSwitch,
                    actionType: LmuListItemAction.toggle,
                    initialValue: isEnabled,
                    onChange: (value) {
                      LmuVibrations.secondary();
                      final newPreference = value
                          ? AnalyticsPreference.enabled
                          : AnalyticsPreference.disabled;
                      analyticsUserPreferenceService.toggleAnalytics(newPreference);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: LmuSizes.size_8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LmuText.bodyXSmall(
                    context.locals.settings.analyticsDescription,
                    color: context.colors.neutralColors.textColors.weakColors.base,
                  ),
                  Text.rich(
                    TextSpan(
                      text: context.locals.settings.analyticsLink,
                      style: LmuText.bodyXSmall('').getTextStyle(context).copyWith(
                            color: context.colors.neutralColors.textColors.weakColors.base,
                          ),
                      children: [
                        TextSpan(
                          text: context.locals.launchFlow.dataPrivacyLabel,
                          style: LmuText.bodyXSmall('').getTextStyle(context).copyWith(
                                color: context.colors.neutralColors.textColors.weakColors.base,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                                decorationColor: context.colors.neutralColors.textColors.weakColors.base,
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
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }
}
