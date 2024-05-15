import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:mensa/src/utils/mensa_days.dart';
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
  late PageController mensaDayPageController;
  late PageController mensaOverviewPageController;
  late DateTime currentMensaDay;

  List<DateTime> mensaDays = getMensaDays();

  @override
  void initState() {
    super.initState();
    mensaDayScrollController = ScrollController();
    mensaDayPageController = PageController();
    mensaOverviewPageController = PageController();
    currentMensaDay = DateTime.now();

    /**int currentIndex = mensaDays.indexWhere((day) =>
        day.year == currentMensaDay.year &&
        day.month == currentMensaDay.month &&
        day.day == currentMensaDay.day);

        int pageIndex = currentIndex ~/ 5;

        WidgetsBinding.instance.addPostFrameCallback((_) {
        mensaDayPageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
        );
        });**/
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

  DateTime currentMensaDay;
  final DateTime mensaDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: areMensaDaysEqual(currentMensaDay, mensaDay)
            ? context.colors.neutralColors.backgroundColors.weakColors.active
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            convertMensaDayToText(mensaDay),
            style: areMensaDaysEqual(currentMensaDay, mensaDay)
                ? const TextStyle(fontWeight: FontWeight.w600)
                : const TextStyle(),
          ),
        ),
      ),
    );
  }
}

class _MensaOverviewItem extends StatelessWidget {
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
      ],
    );
  }
}
