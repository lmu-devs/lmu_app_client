import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/timeline_cubit/cubit.dart';
import '../widgets/timeline_content_view.dart';
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
      largeTitle: context.locals.timeline.datesTitle,
      leadingAction: LeadingAction.back,
      body: BlocBuilder<TimelineCubit, TimelineState>(
        bloc: GetIt.I.get<TimelineCubit>(),
        builder: (context, state) {
          Widget child = const TimelineLoadingView(key: ValueKey("timelineLoading"));
          if (state is TimelineLoadInProgress && state.data != null) {
            child = TimelineContentView(key: const ValueKey("timelineContent"), data: state.data!);
          } else if (state is TimelineLoadSuccess) {
            child = TimelineContentView(key: const ValueKey("timelineContent"), data: state.data);
          }
          return LmuPageAnimationWrapper(child: child);
        },
      ),
    );
  }
}
