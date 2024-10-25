import 'package:core/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/bloc/mensa_menu_cubit/mensa_menu_cubit.dart';
import 'package:mensa/src/repository/api/api.dart';
import 'package:mensa/src/repository/mensa_repository.dart';
import 'package:mensa/src/utils/mensa_day.dart';

import '../views/mensa_details_view.dart';

class MensaDetailsPage extends StatelessWidget {
  const MensaDetailsPage({
    required this.arguments,
    super.key,
  });

  final Object? arguments;

  @override
  Widget build(BuildContext context) {
    final mensaModel = (arguments as MensaDetailsRouteArguments).mensaModel as MensaModel;
    final MensaDay selectedMensaDay = (arguments as MensaDetailsRouteArguments).mensaDay as MensaDay;

    final mensaRepository = ConnectedMensaRepository(
      mensaApiClient: MensaApiClient(),
    );

    return BlocProvider<MensaMenuCubit>(
      create: (context) => MensaMenuCubit(
        mensaRepository: mensaRepository,
      )..loadMensaMenuData(
          mensaModel.canteenId,
          selectedMensaDay.year,
          30.toString(),
          true,
        ),
      child: MensaDetailsView(
        mensaModel: mensaModel,
      ),
    );
  }
}
