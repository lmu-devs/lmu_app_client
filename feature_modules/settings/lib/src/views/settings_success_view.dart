import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

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
                LmuListItem.chevron(
                  title: "Erscheinungsbild",
                  chevronTitle: "Hell",
                  onTap: () {},
                ),
                LmuListItem.chevron(
                  title: "Sprache",
                  chevronTitle: "Deutsch",
                  onTap: () {},
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
                  onTap: () {},
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
                LmuListItem.chevron(
                  title: "Datenschutz",
                  onTap: () {},
                ),
                LmuListItem.chevron(
                  title: "Impressum",
                  onTap: () {},
                ),
                LmuListItem.chevron(
                  title: "Lizenzen",
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(
              height: LmuSizes.mediumLarge,
            ),
            ConentTile(
              content: [
                LmuListItem.chevron(
                  title: "Feature vorschlagen",
                  mainContentAlignment: MainContentAlignment.center,
                  leadingArea: const _LeadingFancyIcons(icon: Icons.add),
                  onTap: () {},
                ),
                LmuListItem.chevron(
                  title: "Fehler melden",
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
