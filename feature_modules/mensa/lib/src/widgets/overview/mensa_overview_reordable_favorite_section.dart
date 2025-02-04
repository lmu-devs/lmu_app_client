import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../repository/api/models/mensa/mensa_model.dart';
import '../../services/mensa_user_preferences_service.dart';
import '../widgets.dart';

class MensaOverviewReordableFavoriteSection extends StatelessWidget {
  const MensaOverviewReordableFavoriteSection({
    super.key,
    required this.mensaModels,
  });

  final List<MensaModel> mensaModels;

  AnimatedBuilder _buildAnimatedBuilder(Animation<double> animation, Widget child, {bool isReverse = false}) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: LmuAnimations.gentle,
            reverseCurve: isReverse ? LmuAnimations.gentle.flipped : Curves.easeInCubic,
          ),
          child: SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: animation,
              curve: LmuAnimations.gentle,
              reverseCurve: isReverse ? LmuAnimations.gentle.flipped : Curves.easeInCubic,
            ),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userPreferencesService = GetIt.I<MensaUserPreferencesService>();

    final canteenLocals = context.locals.canteen;
    final placeholderTextColor = context.colors.neutralColors.textColors.mediumColors.base;
    final starColor = context.colors.neutralColors.textColors.weakColors.base;

    return ValueListenableBuilder(
      valueListenable: userPreferencesService.favoriteMensaIdsNotifier,
      builder: (context, value, _) {
        return Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
              ),
              child: value.isEmpty
                  ? PlaceholderTile(
                      key: const ValueKey('placeholderTile'),
                      minHeight: 80,
                      content: [
                        LmuText.bodySmall(
                          canteenLocals.emptyFavoritesBefore,
                          color: placeholderTextColor,
                        ),
                        StarIcon(
                          isActive: false,
                          disabledColor: starColor,
                          size: LmuSizes.size_16,
                        ),
                        LmuText.bodySmall(
                          canteenLocals.emptyFavoritesAfter,
                          color: placeholderTextColor,
                        ),
                      ],
                    )
                  : null,
            ),
            AnimatedReorderableListView(
              physics: const NeverScrollableScrollPhysics(),
              longPressDraggable: false,
              shrinkWrap: true,
              items: value,
              insertDuration: const Duration(milliseconds: 1200),
              removeDuration: const Duration(milliseconds: 1000),
              insertItemBuilder: (child, animation) => _buildAnimatedBuilder(animation, child),
              removeItemBuilder: (child, animation) => _buildAnimatedBuilder(animation, child, isReverse: true),
              onReorder: (oldIndex, newIndex) {
                final order = List.of(value);
                final item = order.removeAt(oldIndex);
                order.insert(newIndex, item);
                userPreferencesService.updateFavoriteMensaOrder(order);
              },
              isSameItem: (a, b) => a == b,
              itemBuilder: (context, index) {
                final mensaModel = mensaModels.where((element) => element.canteenId == value[index]).first;
                return MensaOverviewTile(
                  key: ValueKey(mensaModel.canteenId),
                  mensaModel: mensaModel,
                  isFavorite: true,
                  hasDivider: index != value.length - 1,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
