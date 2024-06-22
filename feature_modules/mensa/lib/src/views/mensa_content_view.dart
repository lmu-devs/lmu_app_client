import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/mensa_current_day_cubit/mensa_current_day_cubit.dart';
import '../repository/api/api.dart';
import '../widgets/mensa_overview.dart';
import '../widgets/mensa_week_view.dart';

class MensaContentView extends StatelessWidget {
  const MensaContentView({
    Key? key,
    required this.mensaModels,
  }) : super(key: key);

  final List<MensaModel> mensaModels;

  @override
  Widget build(BuildContext context) {
    final mensaCurrentDayCubit = BlocProvider.of<MensaCurrentDayCubit>(context);

    return Column(
      children: [
        MensaWeekView(
          mensaCurrentDayCubit: mensaCurrentDayCubit,
        ),
        MensaOverview(
          mensaCurrentDayCubit: mensaCurrentDayCubit,
          mensaModels: mensaModels,
        ),
      ],
    );
  }
}
