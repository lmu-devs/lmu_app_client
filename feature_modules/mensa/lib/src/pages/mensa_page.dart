import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/bloc.dart';
import '../services/services.dart';
import '../views/views.dart';
import 'taste_profile_page.dart';

class MensaPage extends StatelessWidget {
  const MensaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.locals.canteen;
    return LmuScaffoldWithAppBar(
      largeTitle: localization.tabTitle,
      largeTitleTrailingWidget: LmuButton(
        title: context.locals.canteen.myTaste,
        emphasis: ButtonEmphasis.secondary,
        onTap: () {
          LmuBottomSheet.showExtended(
            context,
            content: const TasteProfilePage(),
          );
        },
      ),
      body: BlocBuilder<MensaCubit, MensaState>(
        bloc: GetIt.I.get<MensaCubit>(),
        builder: (context, state) {
          if (state is MensaLoadSuccess) {
            final initialSortOption = GetIt.I.get<MensaUserPreferencesService>().initialSortOption;
            return MensaOverviewContentView(
              mensaModels: state.mensaModels,
              initialSortOption: initialSortOption,
            );
          }

          return const MensaOverviewLoadingView();
        },
      ),
    );
  }
}
