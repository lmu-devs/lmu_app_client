import 'package:core/components.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../widgets/widgets.dart';
import '../cubit/sports_cubit/cubit.dart';

class SportsPage extends StatelessWidget {
  const SportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: "Sports", 
      body: BlocBuilder<SportsCubit, SportsState>(
        bloc: GetIt.I.get<SportsCubit>(),
        builder: (context, state) {
          if (state is SportsLoadSuccess) {
            return const SportsContentView();
          }

          return const SportsLoadingView();
        },
      ),
    );
  }
}