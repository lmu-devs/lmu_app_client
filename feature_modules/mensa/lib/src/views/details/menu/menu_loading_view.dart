import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get_it/get_it.dart';

import '../../../bloc/menu_cubit/cubit.dart';
import '../../../services/menu_service.dart';
import '../../../widgets/details/menu/loading/menu_item_tile_loading.dart';

class MenuLoadingView extends StatelessWidget {
  const MenuLoadingView({super.key, required this.canteendId});

  final String canteendId;

  @override
  Widget build(BuildContext context) {
    final mensaCubit = GetIt.I.get<MenuService>().getMenuCubit(canteendId);

    return BlocListener<MenuCubit, MenuState>(
      bloc: mensaCubit,
      listenWhen: (_, current) => current is MenuLoadFailure,
      listener: (context, state) {
        if (state is MenuLoadFailure) {
          final localizations = context.locals.canteen;

          LmuToast.show(
            context: context,
            message: localizations.noConnection,
            actionText: localizations.retry,
            type: ToastType.error,
            onActionPressed: () => mensaCubit.loadMensaMenuData(),
            duration: const Duration(minutes: 5),
          );
        }
      },
      child: SliverStickyHeader(
        header: const LmuTabBarLoading(
          hasDivider: true,
        ),
        sliver: SliverPadding(
          padding: const EdgeInsets.only(top: LmuSizes.size_24),
          sliver: SliverList.builder(
            itemCount: 8,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
                child: MenuItemTileLoading(),
              );
            },
          ),
        ),
      ),
    );
  }
}
