import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/mensa_menu_cubit/mensa_menu_cubit.dart';
import '../repository/api/api.dart';
import '../repository/mensa_repository.dart';

import '../utils/get_calendar_week.dart';
import '../utils/mensa_day.dart';
import '../views/mensa_details_view.dart';

class MensaDetailsPage extends StatelessWidget {
  const MensaDetailsPage({
    super.key,
    required this.mensaModel,
  });

  final MensaModel mensaModel;

  @override
  Widget build(BuildContext context) {
    final mensaRepository = ConnectedMensaRepository(
      mensaApiClient: MensaApiClient(),
    );

    MensaDay today = MensaDay.now();

    return BlocProvider<MensaMenuCubit>(
      create: (context) => MensaMenuCubit(
        mensaRepository: mensaRepository,
      )..loadMensaMenuData(
          mensaModel.canteenId,
          today.year,
          getCalendarWeek(today).toString(),
          true,
        ),
      child: MensaDetailsView(
        mensaModel: mensaModel,
        currentDayOfWeek: today.weekday,
      ),
    );
  }
}
