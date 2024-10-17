import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
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
            ConentTile(
              content: [
                LmuListItem.action(
                  title: "Erscheinungsbild",
                  actionType: LmuListItemAction.chevron,
                  chevronTitle: Provider.of<ThemeProvider>(context, listen: true).themeMode.name,
                  onTap: () {
                    SettingsApperanceRoute().go(context);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: LmuSizes.mediumLarge,
            ),
            ConentTile(
              content: [
                LmuListItem.base(
                  title: "Über LMU Developers",
                ),
                LmuListItem.base(
                  title: "Kontakt aufnehmen",
                  onTap: () {},
                ),
                LmuListItem.base(
                  title: "Spenden",
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(
              height: LmuSizes.mediumLarge,
            ),
            ConentTile(
              content: [
                LmuListItem.action(
                  title: "Datenschutz",
                  actionType: LmuListItemAction.chevron,
                  onTap: () {},
                ),
                LmuListItem.action(
                  title: "Impressum",
                  actionType: LmuListItemAction.chevron,
                  onTap: () {},
                ),
                LmuListItem.action(
                  title: "Lizenzen",
                  actionType: LmuListItemAction.chevron,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(
              height: LmuSizes.mediumLarge,
            ),
            ConentTile(
              content: [
                LmuListItem.action(
                  title: "Feature vorschlagen",
                  actionType: LmuListItemAction.chevron,
                  mainContentAlignment: MainContentAlignment.center,
                  leadingArea: const _LeadingFancyIcons(icon: Icons.add),
                  onTap: () {},
                ),
                LmuListItem.action(
                  title: "Fehler melden",
                  actionType: LmuListItemAction.chevron,
                  mainContentAlignment: MainContentAlignment.center,
                  leadingArea: const _LeadingFancyIcons(icon: Icons.margin),
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
    final backgroundColor = context.colors.neutralColors.backgroundColors.mediumColors.base;
    return Container(
      width: double.infinity,
      height: double.infinity,
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
