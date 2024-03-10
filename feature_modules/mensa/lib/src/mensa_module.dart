import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/mensa_cubit/cubit.dart';
import 'pages/mensa_page.dart';
import 'repository/repository.dart';

class MensaModule extends StatelessWidget {
  const MensaModule({
    required this.arguments,
    super.key,
  });

  final MensaRouteArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MensaCubit(
        mensaRepository: ConnectedMensaRepository(
          mensaApiClient: MensaApiClient(),
        ),
      )..loadMensaData(),
      child: const MensaPage(),
    );
  }
}
