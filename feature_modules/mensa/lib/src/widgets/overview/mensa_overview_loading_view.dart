import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/bloc.dart';
import '../../services/mensa_user_preferences_service.dart';

class MensaOverviewLoadingView extends StatelessWidget {
  const MensaOverviewLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final mensaCubit = GetIt.I.get<MensaCubit>();
    final favoriteMensas = GetIt.I.get<MensaUserPreferencesService>().favoriteMensaIdsNotifier.value;

    return BlocListener<MensaCubit, MensaState>(
      bloc: GetIt.I.get<MensaCubit>(),
      listenWhen: (_, current) => current is MensaLoadFailure,
      listener: (context, state) {
        if (state is MensaLoadFailure) {
          final localizations = context.locals.canteen;
          const duration = Duration(seconds: 10);

          LmuToast.show(
            context: context,
            message: localizations.noConnection,
            actionText: localizations.retry,
            type: ToastType.error,
            duration: duration,
            onActionPressed: () => mensaCubit.loadMensaData(),
          );

          Future.delayed(duration, () {
            mensaCubit.loadMensaData();
          });
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
          child: Column(
            children: [
              LmuTileHeadline.base(title: context.locals.canteen.favorites, customBottomPadding: LmuSizes.size_6),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _calculateFavoriteLoadingItemCount(favoriteMensas.length),
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: LmuSizes.size_6),
                  child: LmuCardLoading(
                    hasTag: true,
                    hasSubtitle: true,
                    subtitleLength: 3,
                    hasLargeImage: false,
                    hasFavoriteStar: true,
                    hasFavoriteCount: true,
                    hasDivider: false,
                  ),
                ),
              ),
              const SizedBox(height: 26),
              LmuTileHeadline.base(title: context.locals.canteen.allCanteens),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    LmuMapImageButton(onTap: () {}),
                    const SizedBox(width: LmuSizes.size_8),
                    LmuIconButton(
                      icon: LucideIcons.search,
                      isDisabled: true,
                      onPressed: () {},
                    ),
                    const SizedBox(width: LmuSizes.size_8),
                    LmuButton(
                      title: context.locals.canteen.alphabetically,
                      emphasis: ButtonEmphasis.secondary,
                      state: ButtonState.disabled,
                      trailingIcon: LucideIcons.chevron_down,
                    ),
                    const SizedBox(width: LmuSizes.size_8),
                    LmuButton(
                      title: context.locals.canteen.openNow,
                      emphasis: ButtonEmphasis.secondary,
                      state: ButtonState.disabled,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: LmuSizes.size_16),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) => const LmuCardLoading(
                  hasTag: true,
                  hasSubtitle: true,
                  subtitleLength: 3,
                  hasLargeImage: true,
                  hasFavoriteStar: true,
                  hasFavoriteCount: true,
                  hasDivider: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateFavoriteLoadingItemCount(int favoriteMensasCount) {
    return favoriteMensasCount > 0 ? favoriteMensasCount : 2;
  }
}
