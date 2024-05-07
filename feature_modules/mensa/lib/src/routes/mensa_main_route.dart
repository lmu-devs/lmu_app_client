import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/mensa_cubit/cubit.dart';
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
    return BlocProvider(
      create: (context) => MensaCubit(
        mensaRepository: ConnectedMensaRepository(
          mensaApiClient: MensaApiClient(),
        ),
      )..loadMensaData(),
      child: const MensaMainPage(),
    );
  }
}
