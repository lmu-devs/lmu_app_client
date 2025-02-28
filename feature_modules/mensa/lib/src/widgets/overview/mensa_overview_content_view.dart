import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../repository/repository.dart';
import '../../services/services.dart';
import '../widgets.dart';
import 'mensa_overview_reordable_favorite_section.dart';

class MensaOverviewContentView extends StatefulWidget {
  const MensaOverviewContentView({super.key, required this.mensaModels});

  final List<MensaModel> mensaModels;

  @override
  State<MensaOverviewContentView> createState() => _MensaOverviewContentViewState();
}

class _MensaOverviewContentViewState extends State<MensaOverviewContentView> {
  final _mensaDistanceService = GetIt.I.get<MensaDistanceService>();
  final _userPreferecesService = GetIt.I.get<MensaUserPreferencesService>();

  List<MensaModel> get _mensaModels => widget.mensaModels;

  @override
  void initState() {
    super.initState();
    _userPreferecesService.sortMensaModels(_mensaModels);
    _mensaDistanceService.addListener(_onDistanceChange);
  }

  void _onDistanceChange() {
    if (_userPreferecesService.sortOptionNotifier.value == SortOption.distance) {
      _userPreferecesService.sortMensaModels(_mensaModels);
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
            LmuTileHeadline.base(title: localizations.favorites, customBottomPadding: LmuSizes.size_6),
            MensaOverviewReordableFavoriteSection(mensaModels: _mensaModels),
            const SizedBox(height: 26),
            LmuTileHeadline.base(
              title: localizations.allCanteens,
              bottomWidget: MensaOverviewButtonSection(mensaModels: widget.mensaModels),
            ),
            MensaOverviewAllSection(mensaModels: _mensaModels),
            const MensaOverviewInfoSection(),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }
}
