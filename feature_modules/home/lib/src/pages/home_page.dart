import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import '../bloc/bloc.dart';
import 'package:shared_api/settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/home_success_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.hasDeletedUserApiKey = false});

  final bool hasDeletedUserApiKey;

  @override
  Widget build(BuildContext context) {
    if (hasDeletedUserApiKey) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        LmuBottomSheet.showExtended(
          context,
          content: const AccountDeletedBottomSheet(),
        );
      });
    }

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

class AccountDeletedBottomSheet extends StatelessWidget {
  const AccountDeletedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        children: [
          const SizedBox(height: LmuSizes.size_64),
          Icon(
            LucideIcons.user_x,
            color: context.colors.brandColors.textColors.strongColors.base,
            size: LmuIconSizes.xlarge,
          ),
          const SizedBox(height: LmuSizes.size_16),
          LmuText.h1(context.locals.settings.accountDeletedTitle),
          const SizedBox(height: LmuSizes.size_16),
          LmuText.body(
            context.locals.settings.accountDeletedText,
            color: context.colors.neutralColors.textColors.mediumColors.base,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          LmuButton(
            title: context.locals.settings.accountDeletedButton,
            size: ButtonSize.large,
            showFullWidth: true,
            onTap: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
          const SizedBox(height: LmuSizes.size_48),
        ],
      ),
    );
  }
}
