import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

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
                  title: localizaitons.appearance,
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
                  title: localizaitons.aboutLmuDevelopers,
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
                  title: localizaitons.contact,
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
                      subject: localizaitons.contactSubject,
                      body: localizaitons.contactBody,
                    );
                  },
                ),
                LmuListItem.action(
                  title: localizaitons.donate,
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
                  title: localizaitons.dataPrivacy,
                  actionType: LmuListItemAction.chevron,
                  onTap: () {},
                ),
                LmuListItem.action(
                  title: localizaitons.imprint,
                  actionType: LmuListItemAction.chevron,
                  onTap: () {},
                ),
                LmuListItem.action(
                  title: localizaitons.licenses,
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
                LmuListItem.base(
                  title: localizaitons.suggestFeature,
                  mainContentAlignment: MainContentAlignment.center,
                  leadingArea: const _LeadingFancyIcons(icon: LucideIcons.plus),
                  onTap: () {
                    GetIt.I.get<FeedbackService>().navigateToSuggestion(context);
                  },
                ),
                LmuListItem.base(
                  title: localizaitons.reportBug,
                  mainContentAlignment: MainContentAlignment.center,
                  leadingArea: const _LeadingFancyIcons(icon: LucideIcons.bug),
                  onTap: () {
                    GetIt.I.get<FeedbackService>().navigateToBugReport(context);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: LmuSizes.mediumLarge,
            ),
            LmuButton(
              title: 'Feedback',
              onTap: () =>
                  GetIt.I.get<FeedbackService>().navigateToFeedback(context),
            ),
            const SizedBox(
              height: LmuSizes.xhuge,
            ),
          ],
        ),
      ),
    );
  }
}

class _LeadingFancyIcons extends StatelessWidget {
  const _LeadingFancyIcons({required this.icon});

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

String _getThemeModeString(
    BuildContext context, SettingsLocalizations localizaitons) {
  final String themeName =
      Provider.of<ThemeProvider>(context, listen: true).themeMode.name;
  switch (themeName.toLowerCase()) {
    case 'system':
      return localizaitons.systemMode;
    case 'dark':
      return localizaitons.darkMode;
    case 'light':
      return localizaitons.lightMode;
    default:
      return localizaitons.systemMode;
  }
}
