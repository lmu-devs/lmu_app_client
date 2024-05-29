import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/bloc/mensa_current_day_cubit/mensa_current_day_cubit.dart';
import 'package:mensa/src/repository/api/api.dart';
import 'package:mensa/src/utils/get_mensa_days.dart';
import 'package:mensa/src/utils/mensa_day.dart';
import 'mensa_overview_tile.dart';

class MensaOverview extends StatefulWidget {
  const MensaOverview({
    Key? key,
    required this.mensaCurrentDayCubit,
    required this.mensaModels,
  }) : super(key: key);

  final MensaCurrentDayCubit mensaCurrentDayCubit;
  final List<MensaModel> mensaModels;

  @override
  MensaOverviewState createState() => MensaOverviewState();
}

class MensaOverviewState extends State<MensaOverview> {
  late final MensaCurrentDayCubit _mensaCurrentDayCubit;
  late final List<MensaModel> _mensaModels;
  late final List<MensaDay> mensaDays;
  late final PageController pageController;

  int pageAnimationCounter = 0;
  bool hasManuallySwitchedPage = false;

  @override
  void initState() {
    super.initState();
    _mensaCurrentDayCubit = widget.mensaCurrentDayCubit;
    _mensaModels = widget.mensaModels;
    mensaDays = getMensaDays(excludeWeekend: true);
    pageController = PageController(initialPage: mensaDays.indexOf(MensaDay.now()));
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocListener<MensaCurrentDayCubit, MensaDay>(
        bloc: _mensaCurrentDayCubit,
        listener: (context, currentMensaDay) {
          final indexOfCurrentMensaDay = mensaDays.indexOf(currentMensaDay);
          if (!hasManuallySwitchedPage) {
            pageAnimationCounter = (indexOfCurrentMensaDay - (pageController.page?.floor() ?? 0)).abs();
            pageController.animateToPage(
              indexOfCurrentMensaDay,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }
          hasManuallySwitchedPage = false;
        },
        child: _buildPageView(),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: pageController,
      itemCount: mensaDays.length,
      onPageChanged: (newPage) {
        if (pageAnimationCounter > 0) {
          pageAnimationCounter--;
          return;
        }
        _mensaCurrentDayCubit.setCurrentMensaDay(newMensaDay: mensaDays[newPage]);
        hasManuallySwitchedPage = true;
      },
      itemBuilder: (context, index) => _MensaOverviewItem(mensaModels: _mensaModels),
    );
  }
}

class _MensaOverviewItem extends StatelessWidget {
  const _MensaOverviewItem({
    Key? key,
    required this.mensaModels,
  }) : super(key: key);

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
