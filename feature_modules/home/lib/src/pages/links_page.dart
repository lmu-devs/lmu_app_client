import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/links/links.dart';
import '../widgets/links/links.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinksCubit, LinksState>(
      bloc: GetIt.I.get<LinksCubit>(),
      builder: (context, state) {
        if (state is LinksLoadSuccess) {
          return LinksContentView(
            links: state.links,
          );
        }
        return const LinksLoadingView();
      },
    );
  }
}
