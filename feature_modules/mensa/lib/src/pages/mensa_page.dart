import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/bloc.dart';
import '../widgets/overview/loading/mensa_overview_loading_view.dart';
import '../widgets/overview/mensa_overview_content_view.dart';
import 'taste_profile_page.dart';

class MensaPage extends StatefulWidget {
  const MensaPage({super.key});

  @override
  State<MensaPage> createState() => _MensaPageState();
}

class _MensaPageState extends State<MensaPage> {
  @override
  void initState() {
    super.initState();

    final mensaCubit = GetIt.I.get<MensaCubit>();
    final tasteProfileCubit = GetIt.I.get<TasteProfileCubit>();
    if (mensaCubit.state is! MensaLoadSuccess) {
      mensaCubit.loadMensaData();
    }
    if (tasteProfileCubit.state is! TasteProfileLoadSuccess) {
      tasteProfileCubit.loadTasteProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.locals.canteen;
    return LmuMasterAppBar(
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
        builder: (_, state) {
          return LmuPageAnimationWrapper(
            child: state is MensaLoadSuccess
                ? MensaOverviewContentView(key: const ValueKey("mensaContent"), mensaModels: state.mensaModels)
                : const MensaOverviewLoadingView(key: ValueKey("mensaLoading")),
          );
        },
      ),
    );
  }
}
