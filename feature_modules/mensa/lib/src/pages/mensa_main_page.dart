import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/bloc/mensa_cubit/cubit.dart';
import 'package:mensa/src/views/views.dart';

class MensaMainPage extends StatelessWidget {
  const MensaMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      appBar: LmuNavigationBar(
        title: "Mensa",
        trailingWidget: GestureDetector(
          onTap: () {
            LmuBottomSheet.show(
              context,
              title: "My Taste",
            );
          },
          child: Container(
            width: 40,
            height: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: BlocBuilder<MensaCubit, MensaState>(
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
      ),
    );
  }
}
