import 'package:core/components.dart';
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
    return LmuMasterAppBar(
      largeTitle: "Roomfinder",
      leadingAction: LeadingAction.back,
      body: BlocBuilder<RoomfinderCubit, RoomfinderState>(
        bloc: GetIt.I.get<RoomfinderCubit>(),
        builder: (context, state) {
          return LmuPageAnimationWrapper(
            child: state is RoomfinderLoadSuccess
                ? RoomfinderContentView(key: const ValueKey("roomfinderContent"), cities: state.cities)
                : const RoomfinderLoadingView(key: ValueKey("roomfinderLoading")),
          );
        },
      ),
    );
  }
}
