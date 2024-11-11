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
    final localizaitons = context.locals.settings;
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
                  title: localizaitons.settingsAppearance,
                  actionType: LmuListItemAction.chevron,
                  chevronTitle: _getThemeModeString(context, localizaitons),
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
                  title: localizaitons.settingsAboutLmuDevelopers,
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
                  title: localizaitons.settingsContact,
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
                      subject: localizaitons.settingsContactSubject,
                      body: localizaitons.settingsContactBody,
                    );
                  },
                ),
                LmuListItem.action(
                  title: localizaitons.settingsDonate,
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
                  title: localizaitons.settingsDataPrivacy,
                  actionType: LmuListItemAction.chevron,
                  onTap: () {},
                ),
                LmuListItem.action(
                  title: localizaitons.settingsImprint,
                  actionType: LmuListItemAction.chevron,
                  onTap: () {},
                ),
                LmuListItem.action(
                  title: localizaitons.settingsLicenses,
                  actionType: LmuListItemAction.chevron,
                  onTap: () {
                    const SettingsLicenceRoute().go(context);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: LmuSizes.mediumLarge,
            ),
            LmuContentTile(
              content: [
                LmuListItem.action(
                  title: localizaitons.settingsSuggestFeature,
                  actionType: LmuListItemAction.chevron,
                  mainContentAlignment: MainContentAlignment.center,
                  leadingArea: const _LeadingFancyIcons(icon: LucideIcons.plus),
                  onTap: () {},
                ),
                LmuListItem.action(
                  title: localizaitons.settingsReportBug,
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

String _getThemeModeString(BuildContext context, SettingsLocalizations localizaitons) {
  final String themeName =
      Provider.of<ThemeProvider>(context, listen: true).themeMode.name;
  switch (themeName.toLowerCase()) {
    case 'system':
      return localizaitons.settingsSystemMode;
    case 'dark':
      return localizaitons.settingsDarkMode;
    case 'light':
      return localizaitons.settingsLightMode;
    default:
      return localizaitons.settingsSystemMode;
  }
}
