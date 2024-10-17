import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/bloc/bloc.dart';
import 'package:mensa/src/repository/api/mensa_api_client.dart';
import 'package:mensa/src/repository/mensa_repository.dart';

import '../views/mensa_main_view.dart';

class MensaMainPage extends StatelessWidget {
  const MensaMainPage({
    required this.arguments,
    super.key,
  });

  final Object? arguments;

  @override
  Widget build(BuildContext context) {
    final mensaRepository = ConnectedMensaRepository(
      mensaApiClient: MensaApiClient(),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<MensaCubit>(
          create: (context) => MensaCubit(
            mensaRepository: mensaRepository,
          )..loadMensaData(),
        ),
        BlocProvider<MensaCurrentDayCubit>(
          create: (context) => MensaCurrentDayCubit(),
        ),
        BlocProvider<MensaFavoriteCubit>(
          create: (context) => MensaFavoriteCubit(
            mensaRepository: mensaRepository,
          ),
        ),
      ],
      child: MensaMainView(),
    );
  }
}
