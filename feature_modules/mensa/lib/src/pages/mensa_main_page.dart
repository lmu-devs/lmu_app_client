import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mensa/src/bloc/bloc.dart';
import 'package:mensa/src/repository/mensa_repository.dart';

import '../views/mensa_main_view.dart';

class MensaMainPage extends StatelessWidget {
  const MensaMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mensaRepository = GetIt.I.get<MensaRepository>();
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
      child: const MensaMainView(),
    );
  }
}
