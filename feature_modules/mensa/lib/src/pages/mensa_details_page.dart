import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/mensa_menu_cubit/mensa_menu_cubit.dart';
import '../repository/api/api.dart';
import '../repository/mensa_repository.dart';

import '../views/mensa_details_view.dart';

class MensaDetailsPage extends StatelessWidget {
  const MensaDetailsPage({
    super.key,
    required this.mensaModel,
  });

  final MensaModel mensaModel;

  @override
  Widget build(BuildContext context) {
    final mensaRepository = ConnectedMensaRepository(
      mensaApiClient: MensaApiClient(),
    );

    return BlocProvider<MensaMenuCubit>(
      create: (context) => MensaMenuCubit(
        mensaRepository: mensaRepository,
      )..loadMensaMenuData(
          mensaModel.canteenId,
          2024,
          45.toString(),
          true,
        ),
      child: MensaDetailsView(
        mensaModel: mensaModel,
      ),
    );
  }
}
