import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/mensa_cubit/cubit.dart';
import '../views/views.dart';

class MensaPage extends StatelessWidget {
  const MensaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Mensa',
            icon: Icon(Icons.restaurant_menu_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.developer_mode_rounded),
            label: 'LMU Developers',
          ),
        ],
      )
    );
  }
}
