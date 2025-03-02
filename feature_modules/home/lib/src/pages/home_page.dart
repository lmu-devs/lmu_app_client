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
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: state is HomeLoadSuccess ? HomeSuccessView(homeData: state.homeData) : const HomeLoadingView(),
          );
        },
      ),
    );
  }
}
