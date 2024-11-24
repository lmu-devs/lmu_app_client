import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../../extensions/extensions.dart';
import '../../repository/api/api.dart';
import '../../services/mensa_user_preferences_service.dart';
import '../../widgets/widgets.dart';

class MensaDetailsContentView extends StatelessWidget {
  const MensaDetailsContentView({
    super.key,
    required this.mensaModel,
    required this.currentDayOfWeek,
  });

  final MensaModel mensaModel;
  final int currentDayOfWeek;

  @override
  Widget build(BuildContext context) {
    final mensaUserPreferencesService = GetIt.I<MensaUserPreferencesService>();
    return LmuScaffoldWithAppBar(
      largeTitle: mensaModel.name,
      imageUrls: mensaModel.images.map((e) => e.url).toList(),
      leadingAction: LeadingAction.back,
      largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
      trailingWidgets: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.small),
          child: ValueListenableBuilder(
            valueListenable: mensaUserPreferencesService.favoriteMensaIdsNotifier,
            builder: (context, favoriteMensaIds, _) {
              return GestureDetector(
                onTap: () {
                  mensaUserPreferencesService.toggleFavoriteMensaId(mensaModel.canteenId);
                },
                child: Row(
                  children: [
                    LmuText.bodySmall(mensaModel.ratingModel.likeCount.formattedLikes),
                    const SizedBox(width: LmuSizes.small),
                    StarIcon(
                        isActive: favoriteMensaIds.contains(mensaModel.canteenId),
                        disabledColor: context.colors.neutralColors.backgroundColors.mediumColors.active),
                  ],
                ),
              );
            },
          ),
        ),
        const LmuIcon(
          icon: LucideIcons.share,
          size: LmuSizes.large,
        ),
      ],
      largeTitleTrailingWidget: MensaTag(type: mensaModel.type),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MensaDetailsInfoSection(mensaModel: mensaModel),
          const MensaDetailsMenuSection(),
        ],
      ),
    );
  }
}
