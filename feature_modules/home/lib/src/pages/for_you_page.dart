import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class ForYouPage extends StatelessWidget {
  const ForYouPage({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: GetIt.I.get<HomeCubit>(),
        builder: (context, state) {
          if (state is HomeLoadSuccess) {
            final homeData = state.homeData;
            return ForYouContentView(
              homeData: homeData,
              pageController: pageController,
            );
          }
          return const ForYouLoadingView();
        },
      ),
    );
  }
}
