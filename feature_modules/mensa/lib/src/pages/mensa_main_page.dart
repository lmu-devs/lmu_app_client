import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/bloc/mensa_cubit/cubit.dart';
import 'package:mensa/src/views/views.dart';
import 'package:mensa/src/widgets/my_taste_button.dart';

class MensaMainPage extends StatelessWidget {
  const MensaMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      appBar: LmuDefaultNavigationBar(
        title: "Mensa",
        trailingWidget: GestureDetector(
          onTap: () {
            LmuBottomSheet.show(
              context,
              title: "My Taste",
            );
          },
          child: MyTasteButton(background: context.colors.neutralColors.backgroundColors.base),
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
