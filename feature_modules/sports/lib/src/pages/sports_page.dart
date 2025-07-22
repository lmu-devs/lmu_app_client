import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/sports_cubit/cubit.dart';
import '../services/sports_state_service.dart';
import '../widgets/widgets.dart';

class SportsPage extends StatefulWidget {
  const SportsPage({super.key});

  @override
  State<SportsPage> createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  late final SportsCubit _sportsCubit;
  @override
  void initState() {
    super.initState();
    _sportsCubit = GetIt.I.get<SportsCubit>();

    if (_sportsCubit.state is! SportsLoadSuccess) {
      _sportsCubit.loadSports();
    } else {
      final stateService = GetIt.I.get<SportsStateService>();
      stateService.resetFilter();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: context.locals.sports.sportsTitle,
        leadingAction: LeadingAction.back,
      ),
      body: BlocBuilder<SportsCubit, SportsState>(
        bloc: GetIt.I.get<SportsCubit>(),
        builder: (context, state) {
          Widget child = const SportsLoadingView(key: ValueKey("sportsLoading"));
          if (state is SportsLoadInProgress && state.sports != null) {
            child = SportsContentView(key: const ValueKey("sportsContent"), sports: state.sports!);
          } else if (state is SportsLoadSuccess) {
            child = SportsContentView(key: const ValueKey("sportsContent"), sports: state.sports);
          } else if (state is SportsLoadFailure) {
            final isNoNetworkError = state.loadState.isNoNetworkError;

            child = LmuEmptyState(
              key: ValueKey("sports${isNoNetworkError ? 'NoNetwork' : 'GenericError'}"),
              type: isNoNetworkError ? EmptyStateType.noInternet : EmptyStateType.generic,
              hasVerticalPadding: true,
              onRetry: () => _sportsCubit.loadSports(),
            );
          }

          return child;
        },
      ),
    );
  }
}
