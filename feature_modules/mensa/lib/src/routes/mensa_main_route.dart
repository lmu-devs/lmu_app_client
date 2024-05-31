import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/bloc/bloc.dart';

import '../pages/mensa_main_page.dart';
import '../repository/repository.dart';

class MensaMainRoute extends StatelessWidget {
  const MensaMainRoute({
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
      child: const MensaMainPage(),
    );
  }
}
