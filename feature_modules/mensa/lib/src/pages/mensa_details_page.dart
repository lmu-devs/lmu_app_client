import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../mensa.dart';
import '../bloc/menu_cubit/cubit.dart';
import '../extensions/likes_formatter_extension.dart';
import '../extensions/opening_hours_extensions.dart';
import '../services/menu_service.dart';
import '../widgets/widgets.dart';

class MensaDetailsPage extends StatefulWidget {
  const MensaDetailsPage({super.key, required this.mensaModel});

  final MensaModel mensaModel;

  @override
  State<MensaDetailsPage> createState() => _MensaDetailsPageState();
}

class _MensaDetailsPageState extends State<MensaDetailsPage> {
  MensaModel get _mensaModel => widget.mensaModel;

  @override
  void initState() {
    super.initState();

    _initMenuCubit();
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
          return GestureDetector(
            onTap: () {
              mensaUserPreferencesService.toggleFavoriteMensaId(_mensaModel.canteenId);
              LmuVibrations.secondary();
            },
            child: Padding(
              padding: const EdgeInsets.all(LmuSizes.size_8),
              child: Row(
                children: [
                  LmuText.bodySmall(_mensaModel.ratingModel.calculateLikeCount(isFavorite)),
                  const SizedBox(width: LmuSizes.size_4),
                  StarIcon(
                    isActive: isFavorite,
                    disabledColor: context.colors.neutralColors.backgroundColors.mediumColors.active,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: _mensaModel.name,
      imageUrls: _mensaModel.images.map((e) => e.url).toList(),
      leadingAction: LeadingAction.back,
      onPopInvoked: (_) => LmuToast.removeAll(context: context),
      onLeadingActionTap: () => LmuToast.removeAll(context: context),
      largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
      trailingWidgets: [_trailingAppBarAction],
      largeTitleTrailingWidget: MensaTag(type: _mensaModel.type),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: MensaDetailsInfoSection(mensaModel: _mensaModel)),
          MensaDetailsMenuSection(
            canteenId: _mensaModel.canteenId,
            mensaStatus: Status.closed,
          ),
        ],
      ),
    );
  }
}
