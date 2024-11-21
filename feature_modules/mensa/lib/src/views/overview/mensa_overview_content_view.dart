import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

import '../../extensions/sort_option_sort_extension.dart';
import '../../repository/api/models/mensa/mensa_model.dart';
import '../../repository/api/models/user_preferences/sort_option.dart';
import '../../widgets/widgets.dart';

class MensaOverviewContentView extends StatelessWidget {
  MensaOverviewContentView({
    Key? key,
    required this.mensaModels,
    SortOption initalSortOption = SortOption.alphabetically,
  })  : sortOptionNotifier = ValueNotifier(initalSortOption),
        sortedMensaModelsNotifier = ValueNotifier(initalSortOption.sort(mensaModels)),
        super(key: key);

  final List<MensaModel> mensaModels;
  final ValueNotifier<SortOption> sortOptionNotifier;
  final ValueNotifier<List<MensaModel>> sortedMensaModelsNotifier;
  final ValueNotifier<bool> isOpenNowFilerNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.canteen;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(LmuSizes.mediumLarge),
        child: Column(
          children: [
            LmuTileHeadline.base(
              title: localizations.favorites,
            ),
            MensaOverviewFavoriteSection(mensaModels: mensaModels),
            const SizedBox(height: LmuSizes.xxlarge),
            LmuTileHeadline.base(
              title: localizations.allCanteens,
              bottomWidget: MensaOverviewButtonSection(
                sortOptionNotifier: sortOptionNotifier,
                isOpenNowFilerNotifier: isOpenNowFilerNotifier,
                sortedMensaModelsNotifier: sortedMensaModelsNotifier,
                mensaModels: mensaModels,
              ),
            ),
            MensaOverviewAllSection(
              sortedMensaModelsNotifier: sortedMensaModelsNotifier,
              isOpenNowFilerNotifier: isOpenNowFilerNotifier,
              mensaModels: mensaModels,
            ),
          ],
        ),
      ),
    );
  }
}
