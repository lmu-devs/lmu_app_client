import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/mensa.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../bloc/menu_cubit/cubit.dart';
import '../../services/menu_service.dart';
import 'menu/loading/menu_loading_view.dart';
import 'menu/menu_content_view.dart';

class MensaDetailsMenuSection extends StatelessWidget {
  const MensaDetailsMenuSection({
    super.key,
    required this.canteenId,
    required this.mensaType,
  });

  final String canteenId;
  final MensaType mensaType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      bloc: GetIt.I.get<MenuService>().getMenuCubit(canteenId),
      builder: (context, state) {
        Widget child = MenuLoadingView(key: const ValueKey("menuLoading"), canteendId: canteenId);
        if (state is MenuLoadSuccess) {
          child =
              MenuContentView(key: const ValueKey("menuContent"), menuModels: state.menuModels, mensaType: mensaType);
        } else if (state is MenuLoadFailure) {
          final isNoNetworkError = state.loadState.isNoNetworkError;
          child = SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: LmuSizes.size_96),
              child: LmuEmptyState(
                hasVerticalPadding: true,
                key: ValueKey("menu${isNoNetworkError ? 'NoNetwork' : 'GenericError'}"),
                type: isNoNetworkError ? EmptyStateType.noInternet : EmptyStateType.generic,
                onRetry: () => GetIt.I.get<MenuService>().getMenuCubit(canteenId).loadMensaMenuData(),
              ),
            ),
          );
        }

        return SliverAnimatedSwitcher(
          switchOutCurve: Curves.easeOut,
          duration: const Duration(milliseconds: 200),
          child: child,
        );
      },
    );
  }
}
