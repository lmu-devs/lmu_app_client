import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../../extensions/extensions.dart';
import '../../repository/api/enums/link_sort_options.dart';

class LinkButtonSection extends StatelessWidget {
  const LinkButtonSection({
    super.key,
    required this.facultyId,
    required this.sortOptionNotifier,
    required this.onSortOptionChanged,
  });

  final int facultyId;
  final ValueNotifier<SortOption> sortOptionNotifier;
  final Future<void> Function(SortOption newOption) onSortOptionChanged;

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
              onPressed: () => LinksSearchRoute(facultyId: facultyId).push(context),
            ),
            LmuSortingButton<SortOption>(
              sortOptionNotifier: sortOptionNotifier,
              options: SortOption.values,
              titleBuilder: (option, context) => option.title(context.locals.canteen),
              iconBuilder: (option) => option.icon,
              onOptionSelected: (newOption, context) async {
                await onSortOptionChanged(newOption);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
