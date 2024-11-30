import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../extensions/sort_option_sort_extension.dart';
import '../../repository/api/models/mensa/mensa_model.dart';
import '../../repository/api/models/user_preferences/sort_option.dart';
import '../../repository/repository.dart';
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

  Future<void> _getPermission() async {
    await Permission.location.onGrantedCallback(
      () {
        print("GRANTED");
        print(Permission.location.status.isGranted);
      },
    ).onDeniedCallback(
      () {
        print("DENIED");
      },
    ).onPermanentlyDeniedCallback(
      () {
        print("MOTHERFUCKER");
      },
    ).request();
  }

  @override
  void initState() {
    super.initState();
    _isOpenNowFilerNotifier = ValueNotifier(false);
    _sortOptionNotifier = ValueNotifier(_initialSortOption);
    _sortedMensaModelsNotifier = ValueNotifier(_initialSortOption.sort(_mensaModels));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getPermission();
    });
  }

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
            MensaOverviewFavoriteSection(mensaModels: widget.mensaModels),
            const SizedBox(height: LmuSizes.xxlarge),
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
            const SizedBox(height: LmuSizes.xhuge),
          ],
        ),
      ),
    );
  }
}
