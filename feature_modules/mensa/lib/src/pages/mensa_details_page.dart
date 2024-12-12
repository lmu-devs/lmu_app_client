import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../mensa.dart';
import '../bloc/menu_cubit/cubit.dart';
import '../extensions/likes_formatter_extension.dart';
import '../services/menu_service.dart';
import '../widgets/widgets.dart';

class MensaDetailsPage extends StatefulWidget {
  const MensaDetailsPage({
    super.key,
    required this.mensaModel,
  });

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
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.small),
      child: ValueListenableBuilder(
        valueListenable: mensaUserPreferencesService.favoriteMensaIdsNotifier,
        builder: (context, favoriteMensaIds, _) {
          return GestureDetector(
            onTap: () {
              mensaUserPreferencesService.toggleFavoriteMensaId(_mensaModel.canteenId);
              LmuVibrations.secondary();
            },
            child: Padding(
              padding: const EdgeInsets.all(LmuSizes.mediumSmall),
              child: Row(
                children: [
                  LmuText.bodySmall(_mensaModel.ratingModel.likeCount.formattedLikes),
                  const SizedBox(width: LmuSizes.small),
                  StarIcon(
                    isActive: favoriteMensaIds.contains(_mensaModel.canteenId),
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
      slivers: [
        SliverToBoxAdapter(child: MensaDetailsInfoSection(mensaModel: _mensaModel)),
        MensaDetailsMenuSection(canteenId: _mensaModel.canteenId),
      ],
    );
  }
}
