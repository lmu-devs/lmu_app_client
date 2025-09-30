import 'package:core/components.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/links/links.dart';
import '../widgets/links/links.dart';

class LinksOverviewPage extends StatefulWidget {
  const LinksOverviewPage({super.key, required this.facultyId});

  final int facultyId;

  @override
  State<LinksOverviewPage> createState() => _LinksOverviewPageState();
}

class _LinksOverviewPageState extends State<LinksOverviewPage> {
  late final LinksCubit _linksCubit;

  @override
  void initState() {
    _linksCubit = GetIt.I.get<LinksCubit>();
    if (_linksCubit.state is! LinksLoadSuccess) {
      _linksCubit.getLinks();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinksCubit, LinksState>(
      bloc: GetIt.I.get<LinksCubit>(),
      builder: (context, state) {
        Widget child = const LinksLoadingView(key: ValueKey("linksLoading"));
        if (state is LinksLoadInProgress && state.links != null) {
          child = LinksContentView(
              key: const ValueKey("linksContent"), facultyId: widget.facultyId, links: state.links!);
        } else if (state is LinksLoadSuccess) {
          child = LinksContentView(
              key: const ValueKey("linksContent"), facultyId: widget.facultyId, links: state.links);
        } else if (state is LinksLoadFailure) {
          final isNoNetworkError = state.loadState.isNoNetworkError;
          child = LmuEmptyState(
            key: ValueKey(
                "links${isNoNetworkError ? 'NoNetwork' : 'GenericError'}"),
            type: isNoNetworkError
                ? EmptyStateType.noInternet
                : EmptyStateType.generic,
            hasVerticalPadding: true,
            onRetry: () => _linksCubit.getLinks(),
          );
        }

        return child;
      },
    );
  }
}
