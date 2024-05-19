import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:mensa/src/bloc/mensa_current_day_cubit/mensa_current_day_cubit.dart';
import 'package:mensa/src/utils/mensa_day.dart';
import 'package:mensa/src/utils/get_mensa_days.dart';
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
  late PageController mensaDayPageController;
  late PageController mensaOverviewPageController;

  late List<MensaDay> mensaDays;
  late MensaDay currentMensaDay;

  @override
  void initState() {
    super.initState();
    mensaDayPageController = PageController();
    mensaOverviewPageController = PageController();

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

    int currentIndex = mensaDays.indexWhere((day) =>
        day.year == currentMensaDay.year && day.month == currentMensaDay.month && day.day == currentMensaDay.day);

    int pageIndex = currentIndex ~/ 5;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      mensaDayPageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          margin: const EdgeInsets.all(12),
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(),
            controller: mensaDayPageController,
            itemCount: (mensaDays.length / 5).ceil(),
            itemBuilder: (context, rowIndex) {
              int startIndex = rowIndex * 5;
              int endIndex = (rowIndex + 1) * 5;
              if (endIndex > mensaDays.length) {
                endIndex = mensaDays.length;
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(endIndex - startIndex, (index) {
                  int currentIndex = startIndex + index;
                  return GestureDetector(
                    onTap: () => setState(() {
                      currentMensaDay = mensaDays[currentIndex];
                      mensaOverviewPageController.animateToPage(currentIndex,
                          duration: const Duration(milliseconds: 500), curve: Curves.ease);
                    }),
                    child: _WeekViewItem(
                      currentMensaDay: currentMensaDay,
                      mensaDay: mensaDays[currentIndex],
                    ),
                  );
                }),
              );
            },
          ),
        ),
        const Divider(),
        Expanded(
          child: PageView.builder(
            controller: mensaOverviewPageController,
            itemCount: mensaDays.length,
            onPageChanged: (newPage) => setState(() {
              mensaDayPageController.animateToPage((newPage / 5).floor(),
                  duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
              currentMensaDay = mensaDays[newPage];
            }),
            itemBuilder: (context, index) => _MensaOverviewItem(),
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

class _WeekViewItem extends StatelessWidget {
  _WeekViewItem({
    required this.currentMensaDay,
    required this.mensaDay,
  });

  MensaDay currentMensaDay;
  final MensaDay mensaDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: currentMensaDay.isEqualTo(mensaDay)
            ? context.colors.neutralColors.backgroundColors.weakColors.active
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            mensaDay.toString(),
            style:
                currentMensaDay.isEqualTo(mensaDay) ? const TextStyle(fontWeight: FontWeight.w600) : const TextStyle(),
          ),
        ),
      ),
    );
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
