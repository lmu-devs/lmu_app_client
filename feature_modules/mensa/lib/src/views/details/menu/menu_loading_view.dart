import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: Column(
        children: [
          const LmuTabBarLoading(),
          const LmuDivider(),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(LmuSizes.mediumLarge),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 7,
            itemBuilder: (context, index) {
              return LmuSkeleton(
                context: context,
                child: const MenuItemTileLoading(),
              );
            },
          ),
        ],
      ),
    );
  }
}
