import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class LinkFilterKeys {
  LinkFilterKeys(_);

  static const String internal = 'internal';
  static const String external = 'external';
}

class LinkButtonSection extends StatelessWidget {
  const LinkButtonSection({
    super.key,
    this.activeFilter,
    required this.onFilterSelected,
  });

  final String? activeFilter;
  final ValueChanged<String?> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LmuTileHeadline.base(title: context.locals.home.allLinksTitle),
        LmuButtonRow(
          hasHorizontalPadding: false,
          buttons: [
            LmuIconButton(
              icon: LucideIcons.search,
              onPressed: () => const LinksSearchRoute().go(context),
            ),
            LmuButton(
              title: context.locals.home.linksFilterInternal,
              emphasis: activeFilter == LinkFilterKeys.internal ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
              action: activeFilter == LinkFilterKeys.internal ? ButtonAction.contrast : ButtonAction.base,
              onTap: () => _onButtonTap(LinkFilterKeys.internal),
            ),
            LmuButton(
              title: context.locals.home.linksFilterExternal,
              emphasis: activeFilter == LinkFilterKeys.external ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
              action: activeFilter == LinkFilterKeys.external ? ButtonAction.contrast : ButtonAction.base,
              onTap: () => _onButtonTap(LinkFilterKeys.external),
            ),
          ],
        ),
      ],
    );
  }

  void _onButtonTap(String filter) {
    if (activeFilter == filter) {
      onFilterSelected(null);
    } else {
      onFilterSelected(filter);
    }
  }
}
