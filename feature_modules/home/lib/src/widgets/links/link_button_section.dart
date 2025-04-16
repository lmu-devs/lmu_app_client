import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../../../home.dart';

class LinkButtonSection extends StatelessWidget {
  const LinkButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LmuTileHeadline.base(title: context.locals.home.allLinksTitle),
        Row(
          children: [
            LmuIconButton(
              icon: LucideIcons.search,
              onPressed: () => const LinksSearchRoute().go(context),
            ),
            const SizedBox(width: LmuSizes.size_8),
            LmuButton(
              title: "All",
              emphasis: ButtonEmphasis.secondary,
              trailingIcon: LucideIcons.chevron_down,
              onTap: () => {},
            ),
          ],
        ),
      ],
    );
  }
}
