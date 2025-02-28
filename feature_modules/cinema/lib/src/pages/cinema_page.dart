import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/cubit.dart';
import '../widgets/widgets.dart';

class CinemaPage extends StatelessWidget {
  const CinemaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: context.locals.cinema.pageTitle,
      leadingAction: LeadingAction.back,
      body: BlocBuilder<CinemaCubit, CinemaState>(
        bloc: GetIt.I.get<CinemaCubit>(),
        builder: (context, state) {
          if (state is CinemaLoadSuccess) {
            return CinemaContentView(
              cinemas: state.cinemas,
              screenings: state.screenings,
            );
          }

          return const CinemaLoadingView();
        },
      ),
    );
  }
}
