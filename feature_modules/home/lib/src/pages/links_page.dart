import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/links/links.dart';
import '../widgets/links/links.dart';

class LinksPage extends StatefulWidget {
  const LinksPage({super.key});

  @override
  State<LinksPage> createState() => _LinksPageState();
}

class _LinksPageState extends State<LinksPage> {
  @override
  void initState() {
    final linksCubit = GetIt.I.get<LinksCubit>();
    if (linksCubit.state is! LinksLoadSuccess) {
      linksCubit.getLinks();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinksCubit, LinksState>(
      bloc: GetIt.I.get<LinksCubit>(),
      builder: (context, state) {
        return LmuPageAnimationWrapper(
          child: state is LinksLoadSuccess
              ? LinksContentView(
                  key: const ValueKey("linksContent"),
                  links: state.links,
                )
              : const LinksLoadingView(
                  key: ValueKey("linksLoading"),
                ),
        );
      },
    );
  }
}
