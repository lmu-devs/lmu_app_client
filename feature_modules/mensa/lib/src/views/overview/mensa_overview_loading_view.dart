import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/bloc.dart';
import '../../services/mensa_user_preferences_service.dart';
import '../../widgets/widgets.dart';

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

          LmuToast.show(
            context: context,
            message: localizations.noConnection,
            actionText: localizations.retry,
            type: ToastType.error,
            onActionPressed: () => mensaCubit.loadMensaData(),
            duration: const Duration(minutes: 66),
          );
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: LmuSizes.size_16,
            vertical: LmuSizes.size_16,
          ),
          child: Column(
            children: [
              LmuTileHeadline.base(
                title: context.locals.canteen.favorites,
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _calculateFavoriteLoadingItemCount(favoriteMensas.length),
                itemBuilder: (context, index) {
                  return const MensaOverviewTileLoading();
                },
              ),
              const SizedBox(height: LmuSizes.size_32),
              LmuTileHeadline.base(
                title: context.locals.canteen.allCanteens,
              ),
              Row(
                children: [
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
                itemBuilder: (context, index) {
                  return const MensaOverviewTileLoading(
                    hasLargeImage: true,
                  );
                },
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
