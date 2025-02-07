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
    return BlocBuilder<SportsCubit, SportsState>(
      bloc: GetIt.I.get<SportsCubit>(),
      builder: (context, state) {
        if (state is SportsLoadSuccess) {
          return SportsContentView(sports: state.sports);
        }

        return const SportsLoadingView();
      },
    );
  }
}
