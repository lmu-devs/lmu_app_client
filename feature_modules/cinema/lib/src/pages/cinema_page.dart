import 'package:core/components.dart';
import 'package:core/localizations.dart';
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
  @override
  void initState() {
    super.initState();
    final cinemaCubit = GetIt.I.get<CinemaCubit>();
    if (cinemaCubit.state is! CinemaLoadSuccess) {
      cinemaCubit.loadCinemaData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: context.locals.cinema.pageTitle,
      leadingAction: LeadingAction.back,
      body: BlocBuilder<CinemaCubit, CinemaState>(
        bloc: GetIt.I.get<CinemaCubit>(),
        builder: (context, state) {
          return LmuPageAnimationWrapper(
            child: state is CinemaLoadSuccess
                ? CinemaContentView(
                    key: const ValueKey("cinemaContent"),
                    cinemas: state.cinemas,
                    screenings: state.screenings,
                  )
                : const CinemaLoadingView(key: ValueKey("cinemaLoading")),
          );
        },
      ),
    );
  }
}
