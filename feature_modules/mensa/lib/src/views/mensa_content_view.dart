import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/bloc/mensa_current_day_cubit/mensa_current_day_cubit.dart';
import 'package:mensa/src/repository/api/api.dart';
import 'package:mensa/src/repository/api/models/mensa_day_hours.dart';
import 'package:mensa/src/repository/api/models/mensa_location.dart';
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

    // For testing purposes of the WeekViewWidget
    mensaModels.add(MensaModel(name: "Mensa con Amore", location: MensaLocation(address: "Leopoldstr. 14", latitude: 2, longitude: 2), canteenId: "343cdf5", openingHours: MensaOpeningHours(mon: MensaDayHours(start: "8", end: "16"), tue: MensaDayHours(start: "8", end: "16"), wed: MensaDayHours(start: "8", end: "16"), thu: MensaDayHours(start: "8", end: "16"), fri: MensaDayHours(start: "8", end: "16"))));

    return Column(
      children: [
        MensaWeekView(Mer
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