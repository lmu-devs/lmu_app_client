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
        return SliverAnimatedSwitcher(
          switchOutCurve: Curves.easeOut,
          duration: const Duration(milliseconds: 200),
          child: state is MenuLoadSuccess
              ? MenuContentView(menuModels: state.menuModels, mensaType: mensaType)
              : MenuLoadingView(canteendId: canteenId),
        );
      },
    );
  }
}
