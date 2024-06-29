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
        horizontal: LmuSizes.mediumLarge,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: LmuSizes.medium,
            ),
            child: LmuText.body(
                "Die App ist noch lange nicht am Ziel. Gute Dinge brauchen Zeit und durchdachte Entscheidungen. Helft uns herauszufinden, welche Funktionen euch am meisten fehlen.",
                color: context.colors.neutralColors.textColors.mediumColors.base,),
          ),
          const SizedBox(
            height: LmuSizes.mediumLarge,
          ),
          TileContent(
            content: [
              LmuListItem.base(
                title: "Unsere Roadmap",
                subtitle: "Unrealistische Meilensteine",
                mainContentAlignment: MainContentAlignment.center,
                trailingArea: const _NextIcon(),
                onTap: () {},
              ),
              LmuListItem.base(
                title: "Beta Tester:in werden",
                subtitle: "Teste die neusten App Features",
                mainContentAlignment: MainContentAlignment.center,
                trailingArea: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LmuIcon(
                      size: LmuIconSizes.medium,
                      icon: Icons.link_off,
                      color: context.colors.neutralColors.textColors.weakColors.base,
                    ),
                  ],
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

class _NextIcon extends StatelessWidget {
  const _NextIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LmuIcon(
          size: LmuIconSizes.medium,
          icon: Icons.arrow_forward_ios,
          color: context.colors.neutralColors.textColors.weakColors.base,
        ),
      ],
    );
  }
}

class TileContent extends BaseTile {
  const TileContent({
    required this.content,
    super.key,
  });

  final List<Widget> content;

  @override
  Widget buildTile(BuildContext context) {
    return Column(
      children: content,
    );
  }
}
