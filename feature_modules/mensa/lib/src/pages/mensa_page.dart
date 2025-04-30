import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/bloc.dart';
import '../widgets/overview/mensa_overview_loading_view.dart';
import '../widgets/overview/mensa_overview_content_view.dart';
import 'taste_profile_page.dart';

class MensaPage extends StatefulWidget {
  const MensaPage({super.key});

  @override
  State<MensaPage> createState() => _MensaPageState();
}

class _MensaPageState extends State<MensaPage> {
  final mensaCubit = GetIt.I.get<MensaCubit>();

  @override
  void initState() {
    super.initState();

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
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: localization.tabTitle,
        largeTitleTrailingWidget: LmuButton(
          title: context.locals.canteen.myTaste,
          emphasis: ButtonEmphasis.secondary,
          onTap: () => LmuBottomSheet.showExtended(context, content: const TasteProfilePage()),
        ),
      ),
      body: BlocBuilder<MensaCubit, MensaState>(
        bloc: mensaCubit,
        builder: (_, state) {
          Widget child = const MensaOverviewLoadingView(key: ValueKey("mensaLoading"));
          if (state is MensaLoadInProgress && state.mensaModels != null) {
            child = MensaOverviewContentView(key: const ValueKey("mensaContent"), mensaModels: state.mensaModels!);
          } else if (state is MensaLoadSuccess) {
            child = MensaOverviewContentView(key: const ValueKey("mensaContent"), mensaModels: state.mensaModels);
          }
          return LmuPageAnimationWrapper(child: child);
        },
      ),
    );
  }
}
