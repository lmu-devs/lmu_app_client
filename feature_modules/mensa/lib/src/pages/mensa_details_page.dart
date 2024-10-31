import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mensa/src/bloc/bloc.dart';
import 'package:mensa/src/bloc/mensa_menu_cubit/mensa_menu_cubit.dart';
import 'package:mensa/src/repository/api/api.dart';
import 'package:mensa/src/repository/mensa_repository.dart';

import '../views/mensa_details_view.dart';

class MensaDetailsPage extends StatelessWidget {
  const MensaDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mensaModel = (GetIt.I.get<MensaCubit>().state as MensaLoadSuccess).mensaModels.first;
    final mensaRepository = ConnectedMensaRepository(
      mensaApiClient: MensaApiClient(),
    );

    return BlocProvider<MensaMenuCubit>(
      create: (context) => MensaMenuCubit(
        mensaRepository: mensaRepository,
      )..loadMensaMenuData(
          mensaModel.canteenId,
          2024,
          30.toString(),
          true,
        ),
      child: MensaDetailsView(
        mensaModel: mensaModel,
      ),
    );
  }
}
