import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/timeline_cubit/cubit.dart';
import '../widgets/widgets.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      bloc: GetIt.I.get<TimelineCubit>(),
      builder: (context, state) {
        if (state is TimelineLoadSuccess) {
          return TimelineContentView(timelineData: state.data);
        }

        return const TimelineLoadingView();
      },
    );
  }
}
