import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../extensions/opening_hours_extensions.dart';
import '../../repository/api/models/mensa/mensa_model.dart';
import '../../services/mensa_status_update_service.dart';
import '../../services/mensa_user_preferences_service.dart';
import '../widgets.dart';

class MensaOverviewAllSection extends StatelessWidget {
  const MensaOverviewAllSection({super.key, required this.mensaModels});

  final List<MensaModel> mensaModels;

  @override
  Widget build(BuildContext context) {
    final userPreferencesService = GetIt.I.get<MensaUserPreferencesService>();

    return ValueListenableBuilder(
      valueListenable: userPreferencesService.sortedMensaModelsNotifier,
      builder: (context, sortedMensaModels, _) {
        return ListenableBuilder(
          listenable: GetIt.I.get<MensaStatusUpdateService>(),
          builder: (context, _) {
            return ValueListenableBuilder(
              valueListenable: userPreferencesService.isOpenNowFilterNotifier,
              builder: (context, isFilterActive, _) {
                final filteredMensaModels = sortedMensaModels.where(
                  (element) {
                    if (!isFilterActive) {
                      return true;
                    }
                    final mensaStatus = element.openingHours.openingHours.status;
                    final isNotClosedOrOpeningSoon = mensaStatus != Status.closed && mensaStatus != Status.openingSoon;
                    final isClosedPerDefault = element.status.isClosed;
                    return isNotClosedOrOpeningSoon && !isClosedPerDefault;
                  },
                ).toList();

                if (filteredMensaModels.isEmpty) {
                  return LmuEmptyState(
                    hasVerticalPadding: true,
                    type: EmptyStateType.closed,
                    description: context.locals.app.allClosedDescription(context.locals.canteen.canteens),
                  );
                }

                return LmuAnimatedListView(
                  valueKey:
                      "${userPreferencesService.sortOptionNotifier.value} • ${filteredMensaModels.map((e) => e.canteenId).join()}",
                  itemCount: filteredMensaModels.length,
                  itemBuilder: (context, index) {
                    return ValueListenableBuilder(
                      valueListenable: userPreferencesService.favoriteMensaIdsNotifier,
                      builder: (context, favoriteMensaIds, _) {
                        final isFavorite = favoriteMensaIds.contains(filteredMensaModels[index].canteenId);
                        return MensaOverviewTile(
                          mensaModel: filteredMensaModels[index],
                          isFavorite: isFavorite,
                          hasDivider: index != mensaModels.length - 1,
                          hasLargeImage: filteredMensaModels[index].images.isNotEmpty,
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
