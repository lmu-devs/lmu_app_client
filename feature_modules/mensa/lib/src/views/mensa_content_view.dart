import 'package:flutter/material.dart';
import 'package:mensa/src/repository/api/api.dart';
import 'package:mensa/src/views/mensa_mocks.dart';
import 'package:mensa/src/widgets/mensa_overview_tile.dart';

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
  late ScrollController mensaDayScrollController;
  late PageController mensaOverviewPageController;
  late MensaDay currentMensaDay;

  @override
  void initState() {
    super.initState();
    mensaDayScrollController = ScrollController();
    mensaOverviewPageController = PageController();
    currentMensaDay = MensaDay(time: DateTime.now(), mensaEntries: MensaMocks.mensaEntries);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          margin: const EdgeInsets.all(12),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: mensaDayScrollController,
            physics: const PageScrollPhysics(),
            itemCount: MensaMocks.mensaDays.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => setState(() {
                currentMensaDay = MensaMocks.mensaDays[index];
                mensaOverviewPageController.animateToPage(index,
                    duration: const Duration(milliseconds: 500), curve: Curves.ease);
              }),
              child: _WeekViewItem(
                currentMensaDay: currentMensaDay,
                mensaDay: MensaMocks.mensaDays[index],
              ),
            ),
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: mensaOverviewPageController,
            itemCount: MensaMocks.mensaDays.length,
            onPageChanged: (newPage) => setState(() {
              currentMensaDay = MensaMocks.mensaDays[newPage];
            }),
            itemBuilder: (context, index) => _MensaOverviewItem(
              mensaDay: MensaMocks.mensaOverview.mensaDays[index],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    mensaDayScrollController.dispose();
    mensaOverviewPageController.dispose();
    super.dispose();
  }
}

class _WeekViewItem extends StatelessWidget {
  _WeekViewItem({
    required this.currentMensaDay,
    required this.mensaDay,
  });

  MensaDay currentMensaDay;
  final MensaDay mensaDay;

  bool _areMensaDaysEqual(DateTime firstDate, DateTime secondDate) {
    return (firstDate.year == secondDate.year &&
        firstDate.month == secondDate.month &&
        firstDate.day == secondDate.day);
  }

  String _convertDateToText(DateTime mensaDay) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tomorrow = today.add(const Duration(days: 1));

    if (_areMensaDaysEqual(mensaDay, now)) {
      return 'Today';
    } else if (_areMensaDaysEqual(mensaDay, tomorrow)) {
      return 'Tomorrow';
    } else {
      return mensaDay.weekday == 1
          ? 'Mo. ${mensaDay.day}'
          : mensaDay.weekday == 2
              ? 'Di. ${mensaDay.day}'
              : mensaDay.weekday == 3
                  ? 'Mi. ${mensaDay.day}'
                  : mensaDay.weekday == 4
                      ? 'Do. ${mensaDay.day}'
                      : mensaDay.weekday == 5
                          ? 'Fr. ${mensaDay.day}'
                          : mensaDay.weekday == 6
                              ? 'Sa. ${mensaDay.day}'
                              : 'So. ${mensaDay.day}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _areMensaDaysEqual(currentMensaDay.time, mensaDay.time) ? Colors.grey : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            _convertDateToText(mensaDay.time),
            style: _areMensaDaysEqual(currentMensaDay.time, mensaDay.time)
                ? const TextStyle(fontWeight: FontWeight.bold)
                : const TextStyle(),
          ),
        ),
      ),
    );
  }
}

class _MensaOverviewItem extends StatelessWidget {
  const _MensaOverviewItem({
    required this.mensaDay,
  });

  final MensaDay mensaDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: mensaDay.mensaEntries.length,
            itemBuilder: (context, index) => _MensaEntryItem(
              mensaEntry: mensaDay.mensaEntries[index],
            ),
          ),
        ),
      ],
    );
  }
}

class _MensaEntryItem extends StatelessWidget {
  const _MensaEntryItem({
    required this.mensaEntry,
  });

  final MensaEntry mensaEntry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MensaOverviewTile(
          title: mensaEntry.name,
          distance: mensaEntry.distance,
        ),
      ],
    );
  }
}
