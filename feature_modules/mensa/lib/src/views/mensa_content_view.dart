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

  @override
  void initState() {
    super.initState();
    mensaDayScrollController = ScrollController();
    mensaOverviewPageController = PageController();
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
            itemBuilder: (context, index) => _WeekViewItem(
              position: index,
              mensaDay: MensaMocks.mensaDays[index],
            ),
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: mensaOverviewPageController,
            itemCount: MensaMocks.mensaDays.length,
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
  const _WeekViewItem({
    required this.position,
    required this.mensaDay,
  });

  final int position;
  final MensaDay mensaDay;

  String _convertDate(DateTime mensaDay) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tomorrow = today.add(const Duration(days: 1));

    if (mensaDay.year == now.year && mensaDay.month == now.month && mensaDay.day == now.day) {
      return 'Today';
    } else if (mensaDay.year == tomorrow.year && mensaDay.month == tomorrow.month && mensaDay.day == tomorrow.day) {
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
        color: (position == 0) ? Colors.grey : Colors.transparent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            _convertDate(mensaDay.time),
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
