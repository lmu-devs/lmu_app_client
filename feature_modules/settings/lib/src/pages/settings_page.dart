import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

import '../extensions/enum_naming_extensions.dart';
import '../routes/settings_routes.dart';

class SettingsMainPage extends StatelessWidget {
  const SettingsMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingLocalizations = context.locals.settings;

    final linkIcon = Icon(
      LucideIcons.external_link,
      size: LmuSizes.size_20,
      color: context.colors.neutralColors.textColors.weakColors.base,
    );

    final themeMode = GetIt.I.get<ThemeProvider>();
    final languageMode = GetIt.I.get<LanguageProvider>();

    return LmuMasterAppBar(
      largeTitle: settingLocalizations.settings,
      leadingAction: LeadingAction.back,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: LmuSizes.size_16),
              LmuContentTile(
                content: [
                  LmuListItem.action(
                    title: settingLocalizations.account,
                    actionType: LmuListItemAction.chevron,
                    onTap: () => const SettingsAccountRoute().go(context),
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuContentTile(
                content: [
                  ListenableBuilder(
                    listenable: themeMode,
                    builder: (context, _) => LmuListItem.action(
                      title: settingLocalizations.appearance,
                      actionType: LmuListItemAction.chevron,
                      trailingTitle: _getThemeModeString(themeMode.themeMode, settingLocalizations),
                      onTap: () => const SettingsApperanceRoute().go(context),
                    ),
                  ),
                  ListenableBuilder(
                    listenable: languageMode,
                    builder: (context, _) {
                      return LmuListItem.action(
                        title: settingLocalizations.language,
                        actionType: LmuListItemAction.chevron,
                        trailingTitle: languageMode.isAutomatic
                            ? settingLocalizations.systemMode
                            : languageMode.locale.localizedName(settingLocalizations),
                        onTap: () => const SettingsLanguageRoute().go(context),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuContentTile(
                content: [
                  LmuListItem.base(
                    title: settingLocalizations.aboutLmuDevelopers,
                    trailingArea: linkIcon,
                    onTap: () {
                      LmuUrlLauncher.launchWebsite(
                        context: context,
                        url: LmuDevStrings.lmuDevWebsite,
                        mode: LmuUrlLauncherMode.inAppWebView,
                      );
                    },
                  ),
                  LmuListItem.base(
                    title: settingLocalizations.contact,
                    trailingArea: Icon(
                      LucideIcons.mail,
                      size: LmuIconSizes.mediumSmall,
                      color: context.colors.neutralColors.textColors.weakColors.base,
                    ),
                    onTap: () {
                      LmuUrlLauncher.launchEmail(
                        context: context,
                        email: LmuDevStrings.lmuDevContactMail,
                        subject: settingLocalizations.contactSubject,
                        body: settingLocalizations.contactBody,
                      );
                    },
                  ),
                  LmuListItem.base(
                    title: settingLocalizations.donate,
                    trailingArea: Icon(
                      LucideIcons.heart,
                      size: LmuIconSizes.mediumSmall,
                      color: context.colors.neutralColors.textColors.weakColors.base,
                    ),
                    onTap: () {
                      LmuUrlLauncher.launchWebsite(
                        context: context,
                        url: LmuDevStrings.lmuDevDonate,
                        mode: LmuUrlLauncherMode.inAppWebView,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuContentTile(
                content: [
                  LmuListItem.base(
                    title: settingLocalizations.dataPrivacy,
                    trailingArea: linkIcon,
                    onTap: () {
                      LmuUrlLauncher.launchWebsite(
                        context: context,
                        url: LmuDevStrings.lmuDevDataPrivacy,
                        mode: LmuUrlLauncherMode.inAppWebView,
                      );
                    },
                  ),
                  LmuListItem.base(
                    title: settingLocalizations.legalNotice,
                    trailingArea: linkIcon,
                    onTap: () {
                      LmuUrlLauncher.launchWebsite(
                        context: context,
                        url: LmuDevStrings.lmuDevImprint,
                        mode: LmuUrlLauncherMode.inAppWebView,
                      );
                    },
                  ),
                  LmuListItem.action(
                    title: settingLocalizations.licenses,
                    actionType: LmuListItemAction.chevron,
                    onTap: () => const SettingsLicenceRoute().go(context),
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              kDebugMode
                  ? LmuContentTile(
                      content: [
                        LmuListItem.action(
                          title: "Debug",
                          mainContentAlignment: MainContentAlignment.center,
                          actionType: LmuListItemAction.chevron,
                          onTap: () => const SettingsDebugRoute().go(context),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: kDebugMode ? LmuSizes.size_16 : LmuSizes.none),
              LmuContentTile(
                content: [
                  LmuListItem.base(
                    title: context.locals.app.suggestFeature,
                    mainContentAlignment: MainContentAlignment.center,
                    leadingArea: const LeadingFancyIcons(icon: LucideIcons.plus),
                    onTap: () {
                      GetIt.I.get<FeedbackService>().navigateToSuggestion(context, 'SettingsScreen');
                    },
                  ),
                  LmuListItem.base(
                    title: context.locals.app.reportBug,
                    mainContentAlignment: MainContentAlignment.center,
                    leadingArea: const LeadingFancyIcons(icon: LucideIcons.bug),
                    onTap: () {
                      GetIt.I.get<FeedbackService>().navigateToBugReport(context, 'SettingsScreen');
                    },
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuButton(
                title: context.locals.feedback.feedbackButton,
                onTap: () => GetIt.I.get<FeedbackService>().navigateToFeedback(context, 'SettingsScreen'),
              ),
              const SizedBox(height: LmuSizes.size_96),
            ],
          ),
        ),
      ),
    );
  }
}

String _getThemeModeString(ThemeMode themeMode, SettingsLocalizations localizaitons) {
  return switch (themeMode) {
    ThemeMode.system => localizaitons.systemMode,
    ThemeMode.dark => localizaitons.darkMode,
    ThemeMode.light => localizaitons.lightMode,
  };
}
