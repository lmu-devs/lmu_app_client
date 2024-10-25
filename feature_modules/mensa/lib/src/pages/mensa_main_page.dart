import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/bloc/bloc.dart';

import '../views/mensa_main_view.dart';

class MensaMainPage extends StatelessWidget {
  const MensaMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MensaCurrentDayCubit>(
          create: (context) => MensaCurrentDayCubit(),
        ),
      ],
      child: const MensaMainView(),
    );
  }
}
