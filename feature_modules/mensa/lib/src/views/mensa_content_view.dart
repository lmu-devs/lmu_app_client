import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/bloc/mensa_current_day_cubit/mensa_current_day_cubit.dart';
import 'package:mensa/src/repository/api/models/mensa_model.dart';
import 'package:mensa/src/utils/get_mensa_days.dart';
import 'package:mensa/src/utils/mensa_day.dart';
import 'package:mensa/src/widgets/mensa_overview_tile.dart';
import 'package:mensa/src/widgets/mensa_week_view.dart';

class MensaContentView extends StatefulWidget {
  const MensaContentView({
    Key? key,
    required this.mensaModels,
  }) : super(key: key);

  final List<MensaModel> mensaModels;

  @override
  MensaContentViewState createState() => MensaContentViewState();
}

class MensaContentViewState extends State<MensaContentView> {
  late List<MensaDay> mensaDays;
  late MensaDay currentMensaDay;
  late PageController mensaOverviewController;
  int pageAnimationCounter = 0;
  bool hasManuallySwitchedPage = false;

  @override
  void initState() {
    super.initState();
    mensaDays = getMensaDays();
    currentMensaDay = _initializeCurrentMensaDay();
    mensaOverviewController = PageController(initialPage: mensaDays.indexOf(currentMensaDay));
  }

  MensaDay _initializeCurrentMensaDay() {
    MensaDay today = MensaDay.now();
    if (mensaDays.contains(today)) {
      return today;
    }
    return mensaDays.firstWhere((day) => day.isAfter(today), orElse: () => mensaDays.first);
  }

  @override
  Widget build(BuildContext context) {
    final mensaCurrentDayCubit = BlocProvider.of<MensaCurrentDayCubit>(context);

    return Column(
      children: [
        MensaWeekView(mensaCurrentDayCubit: mensaCurrentDayCubit),
        Expanded(
          child: BlocListener<MensaCurrentDayCubit, MensaDay>(
            bloc: mensaCurrentDayCubit,
            listener: (_, currentMensaDay) {
              _onMensaDayChanged(currentMensaDay);
            },
            child: PageView.builder(
              controller: mensaOverviewController,
              itemCount: mensaDays.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (_, index) => _MensaOverviewItem(
                mensaModels: widget.mensaModels,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onMensaDayChanged(MensaDay currentMensaDay) {
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
  }

  void _onPageChanged(int newPage) {
    if (pageAnimationCounter > 0) {
      pageAnimationCounter--;
      return;
    }
    final mensaCurrentDayCubit = BlocProvider.of<MensaCurrentDayCubit>(context);
    mensaCurrentDayCubit.setCurrentMensaDay(newMensaDay: mensaDays[newPage]);
    hasManuallySwitchedPage = true;
  }

  @override
  void dispose() {
    mensaOverviewController.dispose();
    super.dispose();
  }
}

class _MensaOverviewItem extends StatelessWidget {
  const _MensaOverviewItem({
    required this.mensaModels,
  });

  final List<MensaModel> mensaModels;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mensaModels.length,
            itemBuilder: (context, index) => MensaOverviewTile(title: mensaModels[index].name),
          ),
        ],
      ),
    );
  }
}
