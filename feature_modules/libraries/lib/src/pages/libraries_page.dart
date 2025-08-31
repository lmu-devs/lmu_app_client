import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
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
    final librariesCubit = GetIt.I.get<LibrariesCubit>();
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: context.locals.libraries.pageTitle,
        leadingAction: LeadingAction.back,
        largeTitleTrailingWidget: LmuButton(
          title: context.locals.libraries.seatBooking,
          emphasis: ButtonEmphasis.secondary,
          onTap: () => LmuUrlLauncher.launchWebsite(
              url: "https://auth.anny.eu/start-session?entityId=https://lmuidp.lrz.de/idp/shibboleth",
              context: context,
              mode: LmuUrlLauncherMode.inAppWebView,
          ),
        ),
      ),
      body: BlocBuilder<LibrariesCubit, LibrariesState>(
        bloc: librariesCubit,
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
          } else if (state is LibrariesLoadFailure) {
            final isNoNetworkError = state.loadState.isNoNetworkError;
            child = LmuEmptyState(
              key: ValueKey("libraries${isNoNetworkError ? 'NoNetwork' : 'GenericError'}"),
              type: isNoNetworkError ? EmptyStateType.noInternet : EmptyStateType.generic,
              hasVerticalPadding: true,
              onRetry: () => librariesCubit.loadLibraries(),
            );
          }

          return child;
        },
      ),
    );
  }
}
