import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/mensa.dart';

import '../bloc/menu_cubit/cubit.dart';
import '../extensions/opening_hours_extensions.dart';
import '../repository/api/models/mensa/mensa_model.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class MensaDetailsPage extends StatefulWidget {
  const MensaDetailsPage({super.key, required this.mensaModel});

  final MensaModel mensaModel;

  @override
  State<MensaDetailsPage> createState() => _MensaDetailsPageState();
}

class _MensaDetailsPageState extends State<MensaDetailsPage> {
  late bool _isTemporarilyClosed;
  late bool _isCafeBar;

  MensaModel get _mensaModel => widget.mensaModel;

  @override
  void initState() {
    super.initState();
    _isTemporarilyClosed = _mensaModel.currentOpeningStatus == Status.temporarilyClosed;
    _isCafeBar = _mensaModel.type == MensaType.cafeBar;
    if (!_isTemporarilyClosed && !_isCafeBar) {
      _initMenuCubit();
    }
  }

  void _initMenuCubit() {
    final menuService = GetIt.I.get<MenuService>();
    final canteenId = widget.mensaModel.canteenId;
    final hasMenuCubit = menuService.hasMenuCubit(canteenId);
    if (!hasMenuCubit) {
      menuService.initMenuCubit(canteenId);
    } else {
      final menuCubit = menuService.getMenuCubit(canteenId);
      if (menuCubit.state is MenuLoadFailure) {
        menuCubit.loadMensaMenuData();
      }
    }
  }

  Widget get _trailingAppBarAction {
    final mensaUserPreferencesService = GetIt.I<MensaUserPreferencesService>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_4),
      child: ValueListenableBuilder(
        valueListenable: mensaUserPreferencesService.favoriteMensaIdsNotifier,
        builder: (context, favoriteMensaIds, _) {
          final isFavorite = favoriteMensaIds.contains(_mensaModel.canteenId);
          final calculatedLikes = _mensaModel.ratingModel.calculateLikeCount(isFavorite);
          return LmuFavoriteButton(
            isFavorite: isFavorite,
            calculatedLikes: calculatedLikes,
            onTap: () => mensaUserPreferencesService.toggleFavoriteMensaId(_mensaModel.canteenId),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData.image(
        largeTitle: _mensaModel.name,
        imageUrls: _mensaModel.images.map((e) => e.url).toList(),
        leadingAction: LeadingAction.back,
        largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
        trailingWidgets: [_trailingAppBarAction],
        largeTitleTrailingWidget: MensaTag(type: _mensaModel.type),
      ),
      slivers: [
        SliverToBoxAdapter(child: MensaDetailsInfoSection(mensaModel: _mensaModel)),
        if (!(_isTemporarilyClosed || _isCafeBar))
          MensaDetailsMenuSection(
            canteenId: _mensaModel.canteenId,
            mensaType: _mensaModel.type,
          ),
        if (_isCafeBar) const SliverToBoxAdapter(child: MenuCafeBarView()),
      ],
    );
  }
}
