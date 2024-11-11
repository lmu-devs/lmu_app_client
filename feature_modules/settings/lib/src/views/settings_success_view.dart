import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:provider/provider.dart';

import '../routes/settings_routes.dart';

class SettingsSuccessView extends StatelessWidget {
  const SettingsSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LmuSizes.mediumLarge,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: LmuSizes.mediumLarge,
            ),
            LmuContentTile(
              content: [
                LmuListItem.action(
                  title: context.localizations.settingsAppearance,
                  actionType: LmuListItemAction.chevron,
                  chevronTitle: _getThemeModeString(context),
                  onTap: () {
                    const SettingsApperanceRoute().go(context);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: LmuSizes.mediumLarge,
            ),
            LmuContentTile(
              content: [
                LmuListItem.base(
                  title: context.localizations.settingsAboutLmuDevelopers,
                  trailingArea: Icon(
                    LucideIcons.external_link,
                    size: LmuSizes.large,
                    color:
                        context.colors.neutralColors.textColors.weakColors.base,
                  ),
                  onTap: () {
                    LmuUrlLauncher.launchWebsite(
                        context: context,
                        url: "https://lmu-dev.org",
                        mode: LmuUrlLauncherMode.externalApplication);
                  },
                ),
                LmuListItem.base(
                  title: context.localizations.settingsContact,
                  trailingArea: Icon(
                    LucideIcons.mail,
                    size: LmuSizes.large,
                    color:
                        context.colors.neutralColors.textColors.weakColors.base,
                  ),
                  onTap: () {
                    LmuUrlLauncher.launchEmail(
                      context: context,
                      email: "contact@lmu-dev.org",
                      subject: context.localizations.settingsContactSubject,
                      body: context.localizations.settingsContactBody,
                    );
                  },
                ),
                LmuListItem.action(
                  title: context.localizations.settingsDonate,
                  actionType: LmuListItemAction.chevron,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(
              height: LmuSizes.mediumLarge,
            ),
            LmuContentTile(
              content: [
                LmuListItem.action(
                  title: context.localizations.settingsDataPrivacy,
                  actionType: LmuListItemAction.chevron,
                  onTap: () {},
                ),
                LmuListItem.action(
                  title: context.localizations.settingsImprint,
                  actionType: LmuListItemAction.chevron,
                  onTap: () {},
                ),
                LmuListItem.action(
                  title: context.localizations.settingsLicenses,
                  actionType: LmuListItemAction.chevron,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(
              height: LmuSizes.mediumLarge,
            ),
            LmuContentTile(
              content: [
                LmuListItem.action(
                  title: context.localizations.settingsSuggestFeature,
                  actionType: LmuListItemAction.chevron,
                  mainContentAlignment: MainContentAlignment.center,
                  leadingArea: const _LeadingFancyIcons(icon: LucideIcons.plus),
                  onTap: () {},
                ),
                LmuListItem.action(
                  title: context.localizations.settingsReportBug,
                  actionType: LmuListItemAction.chevron,
                  mainContentAlignment: MainContentAlignment.center,
                  leadingArea: const _LeadingFancyIcons(icon: LucideIcons.bug),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LeadingFancyIcons extends StatelessWidget {
  const _LeadingFancyIcons({required this.icon, super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        context.colors.neutralColors.backgroundColors.mediumColors.base;
    return Container(
      width: LmuSizes.xxxlarge,
      height: LmuSizes.xxxlarge,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          LmuSizes.mediumSmall,
        ),
      ),
      child: LmuIcon(
        size: LmuIconSizes.medium,
        icon: icon,
        color: context.colors.neutralColors.textColors.strongColors.base,
      ),
    );
  }
}

String _getThemeModeString(BuildContext context) {
  final String themeName =
      Provider.of<ThemeProvider>(context, listen: true).themeMode.name;
  switch (themeName.toLowerCase()) {
    case 'system':
      return context.localizations.settingsSystemMode;
    case 'dark':
      return context.localizations.settingsDarkMode;
    case 'light':
      return context.localizations.settingsLightMode;
    default:
      return context.localizations.settingsSystemMode;
  }
}
