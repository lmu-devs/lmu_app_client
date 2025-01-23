import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../widgets/widgets.dart';
import '../cubit/cinema_cubit/cubit.dart';

class CinemaPage extends StatelessWidget {
  const CinemaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CinemaCubit, CinemaState>(
      bloc: GetIt.I.get<CinemaCubit>(),
      builder: (context, state) {
        if (state is CinemaLoadSuccess) {
          return const CinemaContentView();
        }

        return const CinemaLoadingView();
      },
    );
  }
}
