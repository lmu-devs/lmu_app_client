import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/bloc/mensa_current_day_cubit/mensa_current_day_cubit.dart';
import 'package:mensa/src/utils/mensa_day.dart';
import 'package:mensa/src/utils/get_mensa_days.dart';
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

  late PageController mensaDayPageController;
  late PageController mensaOverviewPageController;

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

    mensaDayPageController = PageController();
    mensaOverviewPageController = PageController(initialPage: mensaDays.indexOf(currentMensaDay));

    /**int currentIndex = mensaDays.indexWhere((day) =>
        day.year == currentMensaDay.year && day.month == currentMensaDay.month && day.day == currentMensaDay.day);

        int pageIndex = currentIndex ~/ 5;

        WidgetsBinding.instance.addPostFrameCallback((_) {
        mensaDayPageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
        );
        });**/
  }

  @override
  Widget build(BuildContext context) {
    final mensaCurrentDayCubit = BlocProvider.of<MensaCurrentDayCubit>(context);

    return Column(
      children: [
        MensaWeekView(
          hasDivider: true,
          mensaCurrentDayCubit: mensaCurrentDayCubit,
        ),
        Expanded(
          child: BlocListener<MensaCurrentDayCubit, MensaDay>(
            bloc: mensaCurrentDayCubit,
            listener: (context, currentMensaDay) {
              final indexOfCurrentMensaDay = mensaDays.indexOf(currentMensaDay);
              mensaOverviewPageController.animateToPage(
                indexOfCurrentMensaDay,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            child: PageView.builder(
              controller: mensaOverviewPageController,
              itemCount: mensaDays.length,
              onPageChanged: (newPage) {
                print("I do something");
                /**final currentPage = mensaOverviewPageController.page?.floor() ?? 0;
                if (newPage != currentPage) {
                  if (newPage > currentPage) {
                    mensaCurrentDayCubit.incrementMensaDay();
                  } else   {
                    mensaCurrentDayCubit.decrementMensaDay();
                  }
                }**/
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
    mensaDayPageController.dispose();
    mensaOverviewPageController.dispose();
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
