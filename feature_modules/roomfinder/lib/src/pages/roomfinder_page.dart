import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/roomfinder_cubit/cubit.dart';
import '../widgets/widgets.dart';

class RoomfinderPage extends StatefulWidget {
  const RoomfinderPage({super.key});

  @override
  State<RoomfinderPage> createState() => _RoomfinderPageState();
}

class _RoomfinderPageState extends State<RoomfinderPage> {
  @override
  void initState() {
    super.initState();
    final roomfinderCubit = GetIt.I.get<RoomfinderCubit>();

    if (roomfinderCubit.state is! RoomfinderLoadSuccess) {
      roomfinderCubit.loadRoomfinderLocations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: context.locals.roomfinder.title,
        leadingAction: LeadingAction.back,
      ),
      body: BlocBuilder<RoomfinderCubit, RoomfinderState>(
        bloc: GetIt.I.get<RoomfinderCubit>(),
        builder: (_, state) {
          return LmuPageAnimationWrapper(
            child: state is RoomfinderLoadSuccess
                ? const RoomfinderContentView(key: ValueKey("roomfinderContent"))
                : const RoomfinderLoadingView(key: ValueKey("roomfinderLoading")),
          );
        },
      ),
    );
  }
}
