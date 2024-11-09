import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class MensaLoadingView extends StatelessWidget {
  const MensaLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final mensaCubit = GetIt.I.get<MensaCubit>();

    return BlocListener<MensaCubit, MensaState>(
      bloc: GetIt.I.get<MensaCubit>(),
      listenWhen: (_, current) {
        return current is MensaLoadFailure;
      },
      listener: (context, state) {
        if (state is MensaLoadFailure) {
          final localizations = context.localizations;
          final isSuccessfullStream = mensaCubit.stream.map((state) => state is MensaLoadSuccess);

          LmuToast.show(
            context: context,
            message: localizations.noConnection,
            actionText: localizations.retry,
            type: ToastType.error,
            onActionPressed: () => mensaCubit.loadMensaData(),
            duration: const Duration(minutes: 66),
            removeStream: isSuccessfullStream,
          );
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: LmuSizes.mediumLarge,
            vertical: LmuSizes.mediumLarge,
          ),
          child: Column(
            children: [
              LmuTileHeadline.base(
                title: context.localizations.favorites,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const MensaOverviewTileLoading();
                },
              ),
              const SizedBox(height: LmuSizes.xxlarge),
              LmuTileHeadline.base(
                title: context.localizations.allCanteens,
              ),
              Row(
                children: [
                  LmuButton(
                    title: context.localizations.alphabetically,
                    emphasis: ButtonEmphasis.secondary,
                    state: ButtonState.disabled,
                    trailingIcon: LucideIcons.chevron_down,
                  ),
                  const SizedBox(width: LmuSizes.mediumSmall),
                  LmuButton(
                    title: context.localizations.openNow,
                    emphasis: ButtonEmphasis.secondary,
                    state: ButtonState.disabled,
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.mediumLarge),
              ListView.builder(
                shrinkWrap: true,
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
}
