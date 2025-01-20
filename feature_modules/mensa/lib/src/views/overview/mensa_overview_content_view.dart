import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../extensions/sort_option_sort_extension.dart';
import '../../repository/api/models/mensa/mensa_model.dart';
import '../../repository/api/models/user_preferences/sort_option.dart';
import '../../repository/repository.dart';
import '../../services/mensa_distance_service.dart';
import '../../widgets/overview/mensa_overview_reordable_favorite_section.dart';
import '../../widgets/widgets.dart';

class MensaOverviewContentView extends StatefulWidget {
  const MensaOverviewContentView({
    super.key,
    required this.mensaModels,
    this.initialSortOption = SortOption.alphabetically,
  });

  final List<MensaModel> mensaModels;
  final SortOption initialSortOption;

  @override
  State<MensaOverviewContentView> createState() => _MensaOverviewContentViewState();
}

class _MensaOverviewContentViewState extends State<MensaOverviewContentView> {
  late ValueNotifier<bool> _isOpenNowFilerNotifier;
  late ValueNotifier<SortOption> _sortOptionNotifier;
  late ValueNotifier<List<MensaModel>> _sortedMensaModelsNotifier;

  SortOption get _initialSortOption => widget.initialSortOption;

  List<MensaModel> get _mensaModels => widget.mensaModels;

  final _mensaDistanceService = GetIt.I.get<MensaDistanceService>();

  @override
  void initState() {
    super.initState();
    _isOpenNowFilerNotifier = ValueNotifier(false);
    _sortOptionNotifier = ValueNotifier(_initialSortOption);
    _sortedMensaModelsNotifier = ValueNotifier(_initialSortOption.sort(_mensaModels));
    _mensaDistanceService.addListener(_onDistanceChange);
  }

  @override
  void dispose() {
    _mensaDistanceService.removeListener(_onDistanceChange);
    _isOpenNowFilerNotifier.dispose();
    _sortOptionNotifier.dispose();
    _sortedMensaModelsNotifier.dispose();
    super.dispose();
  }

  void _onDistanceChange() {
    if (_sortOptionNotifier.value == SortOption.distance) {
      _sortedMensaModelsNotifier.value = _sortOptionNotifier.value.sort(_mensaModels);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.canteen;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: Column(
          children: [
            LmuTileHeadline.base(title: localizations.favorites),
            MensaOverviewReordableFavoriteSection(mensaModels: widget.mensaModels),
            const SizedBox(height: LmuSizes.size_24),
            LmuTileHeadline.base(
              title: localizations.allCanteens,
              bottomWidget: MensaOverviewButtonSection(
                sortOptionNotifier: _sortOptionNotifier,
                isOpenNowFilerNotifier: _isOpenNowFilerNotifier,
                sortedMensaModelsNotifier: _sortedMensaModelsNotifier,
                mensaModels: widget.mensaModels,
              ),
            ),
            MensaOverviewAllSection(
              sortedMensaModelsNotifier: _sortedMensaModelsNotifier,
              isOpenNowFilerNotifier: _isOpenNowFilerNotifier,
              mensaModels: widget.mensaModels,
            ),
            MensaOverviewInfoSection(localizations: localizations),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }
}
