import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/mensa_cubit/cubit.dart';
import '../services/taste_profile_service.dart';
import '../views/views.dart';
import 'test.dart';

class MensaMainPage extends StatelessWidget {
  const MensaMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      appBar: LmuDefaultNavigationBar(
        title: "Mensa",
        trailingWidget: LmuButton(
          title: context.localizations.myTaste,
          emphasis: ButtonEmphasis.secondary,
          onTap: () async {
            final tasteProfileService = GetIt.I.get<TasteProfileService>();
            final saveModel = await tasteProfileService.loadTasteProfileState();
            if (context.mounted) {
              LmuBottomSheet.showExtended(
                context,
                content: TasteProfilePage(
                  selectedPresets: saveModel.selectedPresets,
                  excludedLabels: saveModel.excludedLabels,
                  isActive: saveModel.isActive,
                ),
              );
            }
          },
        ),
      ),
      body: Center(
        child: BlocBuilder<MensaCubit, MensaState>(
          bloc: GetIt.I.get<MensaCubit>(),
          builder: (context, state) {
            if (state is MensaLoadInProgress) {
              return const MensaLoadingView();
            } else if (state is MensaLoadSuccess) {
              return MensaContentView(
                mensaModels: state.mensaModels,
              );
            }
            return const MensaErrorView();
          },
        ),
      ),
    );
  }
}
