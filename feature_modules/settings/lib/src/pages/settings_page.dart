import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:core_routes/settings.dart';
import 'package:core_routes/studies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

import '../extensions/enum_naming_extensions.dart';

class SettingsMainPage extends StatelessWidget {
  const SettingsMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final settingLocalizations = context.locals.settings;

    final linkIcon = Icon(
      LucideIcons.external_link,
      size: LmuSizes.size_20,
      color: colors.neutralColors.textColors.weakColors.base,
    );

    final themeMode = GetIt.I.get<ThemeProvider>();
    final languageMode = GetIt.I.get<LanguageProvider>();
    final feedbackApi = GetIt.I.get<FeedbackApi>();
    final systemInfo = GetIt.I.get<SystemInfoService>().systemInfo;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: settingLocalizations.settings,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: LmuSizes.size_16),
              LmuContentTile(
                contentList: [
                  LmuListItem.action(
                    title: settingLocalizations.account,
                    actionType: LmuListItemAction.chevron,
                    onTap: () => const SettingsAccountRoute().go(context),
                  ),
                  LmuListItem.action(
                    title: settingLocalizations.changeFaculty,
                    actionType: LmuListItemAction.chevron,
                    onTap: () => const FaculitesMainRoute().go(context),
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuContentTile(
                contentList: [
                  ListenableBuilder(
                    listenable: themeMode,
                    builder: (context, _) => LmuListItem.action(
                      title: settingLocalizations.appearance,
                      actionType: LmuListItemAction.chevron,
                      trailingTitle: _getThemeModeString(
                          themeMode.themeMode, settingLocalizations),
                      onTap: () => const SettingsAppearanceRoute().go(context),
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
                            : languageMode.locale
                                .localizedName(settingLocalizations),
                        onTap: () => const SettingsLanguageRoute().go(context),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuContentTile(
                contentList: [
                  LmuListItem.action(
                    title: "Analytics",
                    actionType: LmuListItemAction.chevron,
                    onTap: () => const SettingsAnalyticsRoute().go(context),
                  ),
                  LmuListItem.action(
                    title: settingLocalizations.notificationsTitle,
                    actionType: LmuListItemAction.chevron,
                    onTap: () => const SettingsNotificationsRoute().go(context),
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuContentTile(
                contentList: [
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
                      color: colors.neutralColors.textColors.weakColors.base,
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
                      color: colors.neutralColors.textColors.weakColors.base,
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
                contentList: [
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
                        url: LmuDevStrings.lmuDevLegalNotice,
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
                      content: LmuListItem.action(
                        title: "Debug",
                        mainContentAlignment: MainContentAlignment.center,
                        actionType: LmuListItemAction.chevron,
                        onTap: () => const SettingsDebugRoute().go(context),
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                  height: kDebugMode ? LmuSizes.size_16 : LmuSizes.none),
              LmuContentTile(
                contentList: [
                  LmuListItem.base(
                    title: context.locals.app.suggestFeature,
                    mainContentAlignment: MainContentAlignment.center,
                    leadingArea:
                        const LeadingFancyIcons(icon: LucideIcons.plus),
                    onTap: () {
                      feedbackApi.showFeedback(
                        context,
                        args: const FeedbackArgs(
                            type: FeedbackType.suggestion,
                            origin: 'SettingsScreen'),
                      );
                    },
                  ),
                  LmuListItem.base(
                    title: context.locals.app.reportBug,
                    mainContentAlignment: MainContentAlignment.center,
                    leadingArea: const LeadingFancyIcons(icon: LucideIcons.bug),
                    onTap: () {
                      feedbackApi.showFeedback(
                        context,
                        args: const FeedbackArgs(
                            type: FeedbackType.bug, origin: 'SettingsScreen'),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_32),
              LmuText.bodyXSmall(
                '${systemInfo.appName} • ${systemInfo.appVersion}',
                color: colors.neutralColors.textColors.mediumColors.base,
              ),
              const SizedBox(height: LmuSizes.size_2),
              LmuText.bodyXSmall(
                'Created by ${LmuDevStrings.devTeam}, ${DateTime.now().year} ©',
                color: colors.neutralColors.textColors.mediumColors.base,
              ),
              const SizedBox(height: LmuSizes.size_96),
            ],
          ),
        ),
      ),
    );
  }
}

String _getThemeModeString(
    ThemeMode themeMode, SettingsLocalizations localizations) {
  return switch (themeMode) {
    ThemeMode.system => localizations.systemMode,
    ThemeMode.dark => localizations.darkMode,
    ThemeMode.light => localizations.lightMode,
  };
}
