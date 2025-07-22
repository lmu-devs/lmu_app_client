import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/cubit.dart';
import '../widgets/widgets.dart';

class CinemaPage extends StatefulWidget {
  const CinemaPage({super.key});

  @override
  State<CinemaPage> createState() => _CinemaPageState();
}

class _CinemaPageState extends State<CinemaPage> {
  late final CinemaCubit cinemaCubit;
  @override
  void initState() {
    super.initState();
    cinemaCubit = GetIt.I.get<CinemaCubit>();
    if (cinemaCubit.state is! CinemaLoadSuccess) {
      cinemaCubit.loadCinemaData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: context.locals.cinema.pageTitle,
        leadingAction: LeadingAction.back,
      ),
      body: BlocBuilder<CinemaCubit, CinemaState>(
        bloc: cinemaCubit,
        builder: (context, state) {
          Widget child = const CinemaLoadingView(key: ValueKey("cinemaLoading"));

          if (state is CinemaLoadInProgress && state.cinemas != null && state.screenings != null) {
            child = CinemaContentView(
              key: const ValueKey("cinemaContent"),
              cinemas: state.cinemas!,
              screenings: state.screenings!,
            );
          } else if (state is CinemaLoadSuccess) {
            child = CinemaContentView(
              key: const ValueKey("cinemaContent"),
              cinemas: state.cinemas,
              screenings: state.screenings,
            );
          } else if (state is CinemaLoadFailure) {
            final isNoNetworkError = state.loadState.isNoNetworkError;

            child = LmuEmptyState(
              key: ValueKey("cinema${isNoNetworkError ? 'NoNetwork' : 'GenericError'}"),
              type: isNoNetworkError ? EmptyStateType.noInternet : EmptyStateType.generic,
              hasVerticalPadding: true,
              onRetry: () => cinemaCubit.loadCinemaData(),
            );
          }
          return child;
        },
      ),
    );
  }
}
