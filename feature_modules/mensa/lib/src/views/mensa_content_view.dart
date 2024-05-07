import 'package:flutter/material.dart';

import '../repository/api/models/models.dart';
import '../widgets/mensa_overview_tile.dart';

class MensaContentView extends StatelessWidget {
  const MensaContentView({
    required this.mensaData,
    super.key,
  });

  final String mensaData;

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();

    final openingHours = MensaOpeningHours(
      dayAsEnum: Weekday.monday,
      openingHours: ["8-12"],
    );

    final mensaEntries = [
      MensaEntry(
        name: "Leopold",
        type: MensaType.mensa,
        distance: 23,
        isFavorite: true,
        openingHours: openingHours,
      ),
      MensaEntry(
        name: "Schelling",
        type: MensaType.bistro,
        distance: 50,
        isFavorite: false,
        openingHours: openingHours,
      )
    ];

    final mensaDays = [
      MensaDay(
        time: DateTime.now(),
        mensaEntries: mensaEntries,
      ),
      MensaDay(
        time: DateTime.utc(2022),
        mensaEntries: mensaEntries,
      ),
      MensaDay(
        time: DateTime.utc(2022),
        mensaEntries: mensaEntries,
      ),
      MensaDay(
        time: DateTime.utc(2022),
        mensaEntries: mensaEntries,
      ),
    ];

    final mensaOverview = MensaOverview(mensaDays: mensaDays);

    return PageView.builder(
      controller: _pageController,
      itemCount: mensaOverview.mensaDays.length,
      itemBuilder: (context, index) => _MensaOverivewItem(
        mensaDay: mensaOverview.mensaDays[index],
      ),
    );
  }
}

class _MensaOverivewItem extends StatelessWidget {
  const _MensaOverivewItem({
    required this.mensaDay,
  });

  final MensaDay mensaDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              width: 20,
              height: 20,
              color: Colors.green,
            ),
          ),
        ),
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
