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
          return Align(
            alignment: Alignment.topCenter,
            child: LmuPageAnimationWrapper(
              child: state is SportsLoadSuccess
                  ? SportsContentView(key: const ValueKey("sportsContent"), sports: state.sports)
                  : const SportsLoadingView(key: ValueKey("sportsLoading")),
            ),
          );
        },
      ),
    );
  }
}
