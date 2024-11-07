import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/mensa_cubit/cubit.dart';
import '../views/views.dart';

class MensaMainPage extends StatelessWidget {
  const MensaMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      appBar: const LmuDefaultNavigationBar(
        title: "Mensa",
      ),
      body: BlocBuilder<MensaCubit, MensaState>(
        bloc: GetIt.I.get<MensaCubit>(),
        builder: (context, state) {
          if (state is MensaLoadInProgress) {
            return const MensaLoadingView();
          } else if (state is MensaLoadSuccess) {
            return MensaContentView(
              mensaModels: state.mensaModels,
            );
          }
          return const MensaErrorView();
        },
      ),
    );
  }
}
