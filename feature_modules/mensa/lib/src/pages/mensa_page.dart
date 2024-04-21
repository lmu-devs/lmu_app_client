import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/mensa_cubit/cubit.dart';
import '../views/views.dart';

class MensaPage extends StatelessWidget {
  const MensaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      appBar: JoyNavigationBar(
        title: "Mensa",
        trailingWidget: Container(
          width: 40,
          height: 20,
          color: Colors.black,
        ),
      ),
      body: Center(
        child: BlocBuilder<MensaCubit, MensaState>(
          builder: (context, state) {
            if (state is MensaLoadInProgress) {
              return const MensaLoadingView();
            } else if (state is MensaLoadSuccess) {
              return MensaContentView(
                mensaData: state.mensaData,
              );
            }
            return const MensaErrorView();
          },
        ),
      ),
    );
  }
}
