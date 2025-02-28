import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../../../bloc/bloc.dart';
import '../../../services/mensa_user_preferences_service.dart';
import '../../widgets.dart';

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
                  child: MensaOverviewTileLoading(hasDivider: false),
                ),
              ),
              const SizedBox(height: 26),
              LmuTileHeadline.base(title: context.locals.canteen.allCanteens),
              Row(
                children: [
                  Container(
                    height: LmuActionSizes.base,
                    width: LmuActionSizes.base,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
                      border: Border.all(
                        color: context.colors.neutralColors.borderColors.seperatorLight,
                      ),
                      image: DecorationImage(
                        image: AssetImage(getPngAssetTheme('assets/maps_icon'), package: "mensa"),
                      ),
                    ),
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
              const SizedBox(height: LmuSizes.size_16),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) => const MensaOverviewTileLoading(hasLargeImage: true),
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
