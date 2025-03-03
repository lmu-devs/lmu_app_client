import 'package:core/components.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/timeline_cubit/cubit.dart';
import '../widgets/widgets.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  void initState() {
    final timelineCubit = GetIt.I.get<TimelineCubit>();
    if (timelineCubit.state is! TimelineLoadSuccess) {
      timelineCubit.loadTimeline();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: "Termine",
      leadingAction: LeadingAction.back,
      body: BlocBuilder<TimelineCubit, TimelineState>(
        bloc: GetIt.I.get<TimelineCubit>(),
        builder: (context, state) {
          return LmuPageAnimationWrapper(
            child: state is TimelineLoadSuccess
                ? TimelineContentView(key: const ValueKey("timelineContent"), timelineData: state.data)
                : const TimelineLoadingView(key: ValueKey("timelineLoading")),
          );
        },
      ),
    );
  }
}
