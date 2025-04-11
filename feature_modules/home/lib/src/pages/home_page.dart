import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/settings.dart';

import '../bloc/bloc.dart';
import '../widgets/home/home_loading_view.dart';
import '../widgets/home/home_success_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: "Home",
      largeTitleTrailingWidget: GestureDetector(
        onTap: () => GetIt.I.get<SettingsService>().navigateToSettings(context),
        child: const LmuIcon(icon: LucideIcons.settings, size: LmuIconSizes.medium),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: GetIt.I.get<HomeCubit>(),
        builder: (_, state) {
          Widget child = const HomeLoadingView(key: ValueKey("homeLoading"));

          if (state is HomeLoadInProgress && state.homeData != null) {
            child = HomeSuccessView(key: const ValueKey("homeContent"), homeData: state.homeData!);
          } else if (state is HomeLoadSuccess) {
            child = HomeSuccessView(key: const ValueKey("homeContent"), homeData: state.homeData);
          }

          return LmuPageAnimationWrapper(child: child);
        },
      ),
    );
  }
}
