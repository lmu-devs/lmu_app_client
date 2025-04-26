import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/cubit.dart';
import '../widgets/widgets.dart';

class LibrariesPage extends StatefulWidget {
  const LibrariesPage({super.key});

  @override
  State<LibrariesPage> createState() => _LibrariesPageState();
}

class _LibrariesPageState extends State<LibrariesPage> {
  @override
  void initState() {
    super.initState();
    final librariesCubit = GetIt.I.get<LibrariesCubit>();
    if (librariesCubit.state is! LibrariesLoadSuccess) {
      librariesCubit.loadLibraries();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: context.locals.libraries.pageTitle,
      leadingAction: LeadingAction.back,
      body: BlocBuilder<LibrariesCubit, LibrariesState>(
        bloc: GetIt.I.get<LibrariesCubit>(),
        builder: (context, state) {
          Widget child = const LibrariesLoadingView(key: ValueKey("librariesLoading"));

          if (state is LibrariesLoadInProgress && state.libraries != null) {
            child = LibrariesContentView(
              key: const ValueKey("librariesContent"),
              libraries: state.libraries!,
            );
          } else if (state is LibrariesLoadSuccess) {
            child = LibrariesContentView(
              key: const ValueKey("librariesContent"),
              libraries: state.libraries,
            );
          }
          return LmuPageAnimationWrapper(child: child);
        },
      ),
    );
  }
}
