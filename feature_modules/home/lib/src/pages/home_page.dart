import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import '../bloc/bloc.dart';
import 'package:shared_api/settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/home_success_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: context.locals.home.tabTitle,
      largeTitleTrailingWidget: GestureDetector(
        onTap: () {
          GetIt.I.get<SettingsService>().navigateToSettings(context);
        },
        child: const LmuIcon(icon: LucideIcons.settings, size: LmuIconSizes.medium),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: GetIt.I.get<HomeCubit>(),
        builder: (context, state) {
          if (state is HomeLoadSuccess) {
            return HomeSuccessView(homeData: state.homeData);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
