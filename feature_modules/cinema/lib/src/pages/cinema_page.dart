import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../widgets/widgets.dart';
import '../cubit/cubit.dart';

class CinemaPage extends StatelessWidget {
  const CinemaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CinemaCubit, CinemaState>(
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
    );
  }
}
