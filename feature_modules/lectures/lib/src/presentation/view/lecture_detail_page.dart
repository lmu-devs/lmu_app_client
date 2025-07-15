import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/src/themes/context_helpers.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class LectureDetailPage extends StatelessWidget {
  final String title;
  const LectureDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: title,
        leadingAction: LeadingAction.back,
        trailingWidgets: [
          IconButton(
            icon: const Icon(Icons.star_border),
            tooltip: 'Favorit',
            onPressed: () {
              // TODO: handle favorite toggle
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tags in paragraph style with 32px padding below
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Master • 6 SWS • Englisch',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            // Row with map, semester dropdown, LSF, Moodle
            Row(
              children: [
                LmuMapImageButton(
                  onTap: () {
                    // TODO: handle map action
                  },
                ),
                const SizedBox(width: 8),
                LmuButton(
                  title: 'Winter 25/26',
                  emphasis: ButtonEmphasis.secondary,
                  trailingIcon: Icons.keyboard_arrow_down,
                  onTap: () {
                    // TODO: semester dropdown
                  },
                ),
                const SizedBox(width: 8),
                LmuButton(
                  title: 'LSF',
                  emphasis: ButtonEmphasis.secondary,
                  onTap: () {
                    // TODO: LSF action
                  },
                ),
                const SizedBox(width: 8),
                LmuButton(
                  title: 'Moodle',
                  emphasis: ButtonEmphasis.secondary,
                  onTap: () {
                    // TODO: Moodle action
                  },
                ),
              ],
            ),
            const SizedBox(height: LmuSizes.size_32),
            // Only the button on the right, no headline
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LmuButton(
                  title: 'Hinzufügen',
                  size: ButtonSize.large,
                  emphasis: ButtonEmphasis.link,
                  action: ButtonAction.base,
                  state: ButtonState.enabled,
                  trailingIcon: LucideIcons.calendar,
                  onTap: () {
                    // TODO: add action
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Tile with list items: Zeit, Dauer, Adresse, Raum, Lehrpersonen
            LmuContentTile(
              contentList: [
                LmuListItem.base(
                  title: 'Zeit',
                  titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                  trailingArea: Text(
                    'wöchtl., Mo, 16:15–17:45',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.colors.neutralColors.textColors.strongColors.base,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                LmuListItem.base(
                  title: 'Dauer',
                  titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                  trailingArea: Text(
                    '12.05.2025 – 23.07.2025',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.colors.neutralColors.textColors.strongColors.base,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                LmuListItem.base(
                  title: 'Adresse',
                  titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                  trailingArea: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Luisenstr. 37 (C)',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: context.colors.neutralColors.textColors.strongColors.base,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      LmuIcon(
                        icon: LucideIcons.map,
                        size: LmuIconSizes.mediumSmall,
                      ),
                    ],
                  ),
                ),
                LmuListItem.base(
                  title: 'Raum',
                  titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                  trailingArea: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'C 006',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: context.colors.neutralColors.textColors.strongColors.base,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      LmuIcon(
                        icon: LucideIcons.external_link,
                        size: LmuIconSizes.mediumSmall,
                      ),
                    ],
                  ),
                ),
                LmuListItem.base(
                  title: 'Lehrpersonen',
                  titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                  trailingArea: Icon(LucideIcons.chevron_right),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tile with Weitere Details
            LmuContentTile(
              contentList: [
                LmuListItem.base(
                  title: 'Weitere Details',
                  titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                  trailingArea: Icon(LucideIcons.chevron_right),
                ),
              ],
            ),
            // Add space divider and update text
            const SizedBox(height: 32),
            Center(
              child: Text(
                'zuletzt aktualisiert am 32.13.3023 25:61',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
