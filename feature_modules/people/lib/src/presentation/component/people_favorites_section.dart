import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../domain/model/people.dart';

class PeopleFavoritesSection extends StatelessWidget {
  final List<People> people;

  const PeopleFavoritesSection({Key? key, required this.people}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locals = context.locals;
    final starColor = context.colors.neutralColors.textColors.weakColors.base;
    final placeholderTextColor = context.colors.neutralColors.textColors.mediumColors.base;

    if (people.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: PlaceholderTile(
          minHeight: 56,
          content: [
            LmuText.bodySmall(locals.peoples.emptyFavoritesBefore ?? 'Keine Favoriten vorhanden.',
                color: placeholderTextColor),
            StarIcon(isActive: false, disabledColor: starColor, size: LmuSizes.size_16),
            LmuText.bodySmall(locals.peoples.emptyFavoritesAfter ?? '', color: placeholderTextColor),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: LmuSizes.size_24,
            child: StarIcon(isActive: true, size: LmuIconSizes.small, disabledColor: starColor),
          ),
          const SizedBox(height: LmuSizes.size_12),
          LmuContentTile(
            contentList: people.map(
              (person) {
                return SizedBox(
                  width: double.infinity, // <-- sorgt für volle Breite
                  child: LmuListItem.action(
                    title: person.name,
                    actionType: LmuListItemAction.chevron,
                    trailingArea: StarIcon(
                      isActive: person.isFavorite,
                      size: LmuIconSizes.small,
                      disabledColor: context.colors.neutralColors.borderColors.seperatorLight,
                    ),
                    onTap: () {
                      context.go('/studies/people/details/${person.id}');
                    },
                  ),
                );
              },
            ).toList(),
          ),
          const SizedBox(height: LmuSizes.size_32),
        ],
      ),
    );
  }
}
