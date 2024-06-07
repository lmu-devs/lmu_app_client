import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/bloc/mensa_current_day_cubit/mensa_current_day_cubit.dart';
import 'package:mensa/src/repository/api/api.dart';
import 'package:mensa/src/widgets/mensa_overview.dart';
import 'package:mensa/src/widgets/mensa_week_view.dart';

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
