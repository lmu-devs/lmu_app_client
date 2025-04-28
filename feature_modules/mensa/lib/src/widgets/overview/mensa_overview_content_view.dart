import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
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
  final _mensaDistanceService = GetIt.I.get<LocationService>();
  final _userPreferencesService = GetIt.I.get<MensaUserPreferencesService>();

  List<MensaModel> get _mensaModels => widget.mensaModels;

  @override
  void initState() {
    super.initState();
    _mensaDistanceService.addListener(_onDistanceChange);
  }

  void _onDistanceChange() {
    if (_userPreferencesService.sortOptionNotifier.value == SortOption.distance) {
      _userPreferencesService.sortMensaModels(_mensaModels);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: LmuSizes.size_16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: Column(
              children: [
                LmuTileHeadline.base(title: context.locals.app.favorites, customBottomPadding: LmuSizes.size_6),
                MensaOverviewReorderableFavoriteSection(mensaModels: _mensaModels),
              ],
            ),
          ),
          const SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: LmuTileHeadline.base(title: context.locals.canteen.allCanteens),
          ),
          MensaOverviewButtonSection(mensaModels: widget.mensaModels),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: Column(
              children: [
                const SizedBox(height: LmuSizes.size_16),
                MensaOverviewAllSection(mensaModels: _mensaModels),
                const MensaOverviewInfoSection(),
                const SizedBox(height: LmuSizes.size_96),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
