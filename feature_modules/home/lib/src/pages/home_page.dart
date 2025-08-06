import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core_routes/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../bloc/bloc.dart';
import '../widgets/home/home_loading_view.dart';
import '../widgets/home/home_success_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: "Home",
        largeTitleTrailingWidget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => const SettingsMainRoute().go(context),
              child: const Padding(
                padding: EdgeInsets.only(left: LmuSizes.size_16),
                child: SizedBox(
                  height: 40,
                  child: LmuIcon(
                      icon: LucideIcons.settings, size: LmuIconSizes.medium),
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: GetIt.I.get<HomeCubit>(),
        builder: (_, state) {
          Widget child = const HomeLoadingView(key: ValueKey("homeLoading"));

          if (state is HomeLoadInProgress && state.tiles != null) {
            child = HomeSuccessView(
                key: const ValueKey("homeContent"),
                tiles: state.tiles!,
                featured: state.featured);
          } else if (state is HomeLoadSuccess) {
            child = HomeSuccessView(
                key: const ValueKey("homeContent"),
                tiles: state.tiles,
                featured: state.featured);
          }

          return LmuPageAnimationWrapper(child: child);
        },
      ),
    );
  }
}
