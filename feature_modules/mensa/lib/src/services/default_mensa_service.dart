import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/utils.dart';
import 'package:core_routes/mensa.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';
import 'package:shared_api/mensa.dart';

import '../bloc/bloc.dart';
import '../extensions/opening_hours_extensions.dart';
import '../widgets/widgets.dart';
import 'menu_service.dart';

class DefaultMensaService implements MensaService {
  @override
  Stream<List<ExploreLocation>> get mensaExploreLocationsStream {
    final mensaCubit = GetIt.I.get<MensaCubit>();
    final tasteProfilCubit = GetIt.I.get<TasteProfileCubit>();
    final state = mensaCubit.state;
    if (state is! MensaLoadSuccess && state is! MensaLoadInProgress) {
      mensaCubit.loadMensaData();
    }

    if (tasteProfilCubit.state is! TasteProfileLoadSuccess && tasteProfilCubit.state is! TasteProfileLoadInProgress) {
      tasteProfilCubit.loadTasteProfile();
    }

    return mensaCubit.stream.withInitialValue(mensaCubit.state).map((state) {
      if (state is MensaLoadInProgress && state.mensaModels != null) {
        return state.mensaModels!.map((mensaModel) {
          return ExploreLocation(
            id: mensaModel.canteenId,
            latitude: mensaModel.location.latitude,
            longitude: mensaModel.location.longitude,
            address: mensaModel.location.address,
            name: mensaModel.name,
            type: mensaModel.type.exploreMarkerType,
          );
        }).toList();
      } else if (state is MensaLoadSuccess) {
        return state.mensaModels.map((mensaModel) {
          return ExploreLocation(
            id: mensaModel.canteenId,
            latitude: mensaModel.location.latitude,
            longitude: mensaModel.location.longitude,
            address: mensaModel.location.address,
            name: mensaModel.name,
            type: mensaModel.type.exploreMarkerType,
          );
        }).toList();
      }
      return [];
    });
  }

  @override
  void navigateToMensaPage(BuildContext context) {
    const MensaMainRoute().go(context);
  }

  @override
  List<Widget> mensaMapContentBuilder(BuildContext context, String mensaId, ScrollController controller) {
    final menuService = GetIt.I.get<MenuService>();

    final hasMenuCubit = menuService.hasMenuCubit(mensaId);
    if (!hasMenuCubit) {
      menuService.initMenuCubit(mensaId);
    } else {
      final menuCubit = menuService.getMenuCubit(mensaId);
      if (menuCubit.state is MenuLoadFailure) {
        menuCubit.loadMensaMenuData();
      }
    }

    final mensaCubit = GetIt.I.get<MensaCubit>();
    final state = mensaCubit.state;
    if (state is! MensaLoadSuccess) return [];

    final mensaModel = state.mensaModels.firstWhereOrNull((mensaModel) => mensaModel.canteenId == mensaId);
    if (mensaModel == null) return [];

    final isTemporarilyClosed = mensaModel.currentOpeningStatus == Status.temporarilyClosed;
    final isCafeBar = mensaModel.type == MensaType.cafeBar;

    return [
      SliverToBoxAdapter(child: LmuDynamicImageGallery(images: mensaModel.images)),
      SliverToBoxAdapter(child: MensaDetailsInfoSection(mensaModel: mensaModel)),
      if (!(isTemporarilyClosed || isCafeBar))
        MensaDetailsMenuSection(
          canteenId: mensaModel.canteenId,
          mensaType: mensaModel.type,
        ),
      if (isCafeBar) const SliverToBoxAdapter(child: MenuCafeBarView()),
    ];
  }
}

extension on MensaType {
  ExploreMarkerType get exploreMarkerType {
    return switch (this) {
      MensaType.mensa => ExploreMarkerType.mensaMensa,
      MensaType.stuBistro => ExploreMarkerType.mensaStuBistro,
      MensaType.stuCafe => ExploreMarkerType.mensaStuCafe,
      MensaType.lounge => ExploreMarkerType.mensaStuLounge,
      MensaType.cafeBar => ExploreMarkerType.mensaStuLounge,
      MensaType.none => ExploreMarkerType.mensaStuLounge,
    };
  }
}
