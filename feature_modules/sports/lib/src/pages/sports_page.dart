import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/sports_cubit/cubit.dart';
import '../widgets/widgets.dart';

class SportsPage extends StatefulWidget {
  const SportsPage({super.key});

  @override
  State<SportsPage> createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  @override
  void initState() {
    final sportsCubit = GetIt.I.get<SportsCubit>();
    if (sportsCubit.state is! SportsLoadSuccess) {
      sportsCubit.loadSports();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: context.locals.sports.sportsTitle,
      leadingAction: LeadingAction.back,
      body: BlocBuilder<SportsCubit, SportsState>(
        bloc: GetIt.I.get<SportsCubit>(),
        builder: (context, state) {
          Widget child = const SportsLoadingView(key: ValueKey("sportsLoading"));

          if (state is SportsLoadInProgress && state.sports != null) {
            child = SportsContentView(key: const ValueKey("sportsContent"), sports: state.sports!);
          } else if (state is SportsLoadSuccess) {
            child = SportsContentView(key: const ValueKey("sportsContent"), sports: state.sports);
          }

          return Align(
            alignment: Alignment.topCenter,
            child: LmuPageAnimationWrapper(child: child),
          );
        },
      ),
    );
  }
}
