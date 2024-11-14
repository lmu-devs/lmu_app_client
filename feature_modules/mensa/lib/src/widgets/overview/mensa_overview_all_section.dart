import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../../extensions/opening_hours_extensions.dart';
import '../../repository/api/models/mensa_model.dart';
import '../../services/mensa_user_preferences_service.dart';
import '../widgets.dart';

class MensaOverviewAllSection extends StatelessWidget {
  const MensaOverviewAllSection({
    super.key,
    required this.sortedMensaModelsNotifier,
    required this.isOpenNowFilerNotifier,
    required this.mensaModels,
  });

  final ValueNotifier<List<MensaModel>> sortedMensaModelsNotifier;
  final ValueNotifier<bool> isOpenNowFilerNotifier;
  final List<MensaModel> mensaModels;

  @override
  Widget build(BuildContext context) {
    final favoriteMensaIdsNotifier = GetIt.I.get<MensaUserPreferencesService>().favoriteMensaIdsNotifier;

    return ValueListenableBuilder(
      valueListenable: favoriteMensaIdsNotifier,
      builder: (context, favoriteMensaIds, _) {
        return ValueListenableBuilder(
          valueListenable: sortedMensaModelsNotifier,
          builder: (context, sortedMensaModels, _) {
            return ValueListenableBuilder(
              valueListenable: isOpenNowFilerNotifier,
              builder: (context, isFilterActive, _) {
                final filteredMensaModels = sortedMensaModels.where(
                  (element) {
                    if (!isFilterActive) {
                      return true;
                    }
                    return element.openingHours.mensaStatus != MensaStatus.closed;
                  },
                ).toList();

                if (filteredMensaModels.isEmpty) {
                  return MensaOverviewPlaceholderTile(
                    title: context.locals.canteen.allClosed,
                    icon: LucideIcons.bone,
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredMensaModels.length,
                  itemBuilder: (context, index) {
                    final isFavorite = favoriteMensaIds.contains(filteredMensaModels[index].canteenId);
                    return MensaOverviewTile(
                      mensaModel: filteredMensaModels[index],
                      isFavorite: isFavorite,
                      hasDivider: index == mensaModels.length - 1,
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
  }
}