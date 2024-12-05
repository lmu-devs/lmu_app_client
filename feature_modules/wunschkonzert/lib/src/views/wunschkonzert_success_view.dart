import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class WunschkonzertSuccessView extends StatelessWidget {
  const WunschkonzertSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LmuSizes.size_16,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: LmuSizes.size_12,
            ),
            child: LmuText.body(
              "Die App ist noch lange nicht am Ziel. Gute Dinge brauchen Zeit und durchdachte Entscheidungen. Helft uns herauszufinden, welche Funktionen euch am meisten fehlen.",
              color: context.colors.neutralColors.textColors.mediumColors.base,
            ),
          ),
          const SizedBox(
            height: LmuSizes.size_16,
          ),
          LmuContentTile(
            content: [
              LmuListItem.action(
                title: "Unsere Roadmap",
                subtitle: "Unrealistische Meilensteine",
                mainContentAlignment: MainContentAlignment.center,
                actionType: LmuListItemAction.chevron,
                onTap: () {},
              ),
              LmuListItem.base(
                title: "Beta Tester:in werden",
                subtitle: "Teste die neusten App Features",
                mainContentAlignment: MainContentAlignment.center,
                trailingArea: LmuIcon(
                  size: LmuIconSizes.medium,
                  icon: Icons.link_off,
                  color: context.colors.neutralColors.textColors.weakColors.base,
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
