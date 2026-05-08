import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
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
  late final RoomfinderCubit roomfinderCubit;
  @override
  void initState() {
    super.initState();
    roomfinderCubit = GetIt.I.get<RoomfinderCubit>();

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
        bloc: roomfinderCubit,
        builder: (_, state) {
          if (state is RoomfinderLoadSuccess) {
            return const RoomfinderContentView();
          } else if (state is RoomfinderLoadFailure) {
            final isNoNetworkError = state.loadState.isNoNetworkError;

            return LmuEmptyState(
              type: isNoNetworkError ? EmptyStateType.noInternet : EmptyStateType.generic,
              hasVerticalPadding: true,
              onRetry: () => roomfinderCubit.loadRoomfinderLocations(),
            );
          }

          return const RoomfinderLoadingView();
        },
      ),
    );
  }
}
