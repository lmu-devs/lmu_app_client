import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/bloc/mensa_current_day_cubit/mensa_current_day_cubit.dart';
import 'package:mensa/src/utils/get_mensa_days.dart';
import 'package:mensa/src/utils/mensa_day.dart';
import 'package:mensa/src/widgets/mensa_overview_tile.dart';
import 'package:mensa/src/widgets/mensa_week_view.dart';

class MensaContentView extends StatefulWidget {
  const MensaContentView({
    Key? key,
    required this.mensaData,
  }) : super(key: key);

  final String mensaData;

  @override
  MensaContentViewState createState() => MensaContentViewState();
}

class MensaContentViewState extends State<MensaContentView> {
  late List<MensaDay> mensaDays;
  late MensaDay currentMensaDay;

  late PageController mensaOverviewController;

  @override
  void initState() {
    super.initState();
    mensaDays = getMensaDays();
    currentMensaDay = MensaDay.now();

    if (!mensaDays.contains(currentMensaDay)) {
      for (MensaDay day in mensaDays) {
        if (day.isAfter(currentMensaDay)) {
          currentMensaDay = day;
          break;
        }
      }
    }

    mensaOverviewController = PageController(initialPage: mensaDays.indexOf(currentMensaDay));
  }

  @override
  Widget build(BuildContext context) {
    final mensaCurrentDayCubit = BlocProvider.of<MensaCurrentDayCubit>(context);
    int pageAnimationCounter = 0;
    bool hasManuallySwitchedPage = false;

    return Column(
      children: [
        MensaWeekView(
          mensaCurrentDayCubit: mensaCurrentDayCubit,
        ),
        Expanded(
          child: BlocListener<MensaCurrentDayCubit, MensaDay>(
            bloc: mensaCurrentDayCubit,
            listener: (context, currentMensaDay) {
              final indexOfCurrentMensaDay = mensaDays.indexOf(currentMensaDay);
              if (!hasManuallySwitchedPage) {
                pageAnimationCounter = (indexOfCurrentMensaDay - (mensaOverviewController.page?.floor() ?? 0)).abs();
                mensaOverviewController.animateToPage(
                  indexOfCurrentMensaDay,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              }
              hasManuallySwitchedPage = false;
            },
            child: PageView.builder(
              controller: mensaOverviewController,
              itemCount: mensaDays.length,
              onPageChanged: (newPage) {
                if (pageAnimationCounter > 0) {
                  pageAnimationCounter--;
                  return;
                }
                mensaCurrentDayCubit.setCurrentMensaDay(newMensaDay: mensaDays[newPage]);
                hasManuallySwitchedPage = true;
              },
              itemBuilder: (context, index) => _MensaOverviewItem(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    mensaOverviewController.dispose();
    super.dispose();
  }
}

class _MensaOverviewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) => const MensaOverviewTile(title: "Mensa Schmensa"),
          ),
        ],
      ),
    );
  }
}
