import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../mensa.dart';
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

    final menuService = GetIt.I.get<MenuService>();
    final canteenId = widget.mensaModel.canteenId;
    final hasMenuCubit = menuService.hasMenuCubit(canteenId);
    if (!hasMenuCubit) {
      menuService.initMenuCubit(canteenId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mensaUserPreferencesService = GetIt.I<MensaUserPreferencesService>();
    return LmuScaffoldWithAppBar(
      largeTitle: _mensaModel.name,
      imageUrls: _mensaModel.images.map((e) => e.url).toList(),
      leadingAction: LeadingAction.back,
      largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
      trailingWidgets: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.small),
          child: ValueListenableBuilder(
            valueListenable: mensaUserPreferencesService.favoriteMensaIdsNotifier,
            builder: (context, favoriteMensaIds, _) {
              return GestureDetector(
                onTap: () {
                  mensaUserPreferencesService.toggleFavoriteMensaId(_mensaModel.canteenId);
                  LmuVibrations.secondary();
                },
                child: Row(
                  children: [
                    LmuText.bodySmall(_mensaModel.ratingModel.likeCount.formattedLikes),
                    const SizedBox(width: LmuSizes.small),
                    StarIcon(
                        isActive: favoriteMensaIds.contains(_mensaModel.canteenId),
                        disabledColor: context.colors.neutralColors.backgroundColors.mediumColors.active),
                  ],
                ),
              );
            },
          ),
        ),
      ],
      largeTitleTrailingWidget: MensaTag(type: _mensaModel.type),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MensaDetailsInfoSection(mensaModel: _mensaModel),
          MensaDetailsMenuSection(canteenId: _mensaModel.canteenId),
        ],
      ),
    );
  }
}
