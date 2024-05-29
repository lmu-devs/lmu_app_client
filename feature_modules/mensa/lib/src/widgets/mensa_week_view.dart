import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/bloc/mensa_current_day_cubit/mensa_current_day_cubit.dart';
import 'package:mensa/src/utils/get_mensa_days.dart';
import 'package:mensa/src/utils/mensa_day.dart';

class MensaWeekView extends StatefulWidget {
  const MensaWeekView({
    Key? key,
    required this.mensaCurrentDayCubit,
    this.hasDivider = true,
  }) : super(key: key);

  final MensaCurrentDayCubit mensaCurrentDayCubit;
  final bool hasDivider;

  @override
  MensaWeekViewState createState() => MensaWeekViewState();
}

class MensaWeekViewState extends State<MensaWeekView> {
  late final MensaCurrentDayCubit _mensaCurrentDayCubit;
  late final List<MensaDay> mensaDays;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    _mensaCurrentDayCubit = widget.mensaCurrentDayCubit;
    mensaDays = getMensaDays(excludeWeekend: true);
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPageView(),
        if (widget.hasDivider) const Divider(thickness: 0.5, height: 0),
      ],
    );
  }

  Widget _buildPageView() {
    return Container(
      height: 36,
      margin: const EdgeInsets.all(12),
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(),
        controller: pageController,
        itemCount: (mensaDays.length / 5).ceil(),
        itemBuilder: (context, rowIndex) => _buildPageViewRow(rowIndex),
      ),
    );
  }

  Widget _buildPageViewRow(int rowIndex) {
    final startIndex = rowIndex * 5;
    final lastIndex = (rowIndex + 1) * 5;
    final endIndex = lastIndex > mensaDays.length ? mensaDays.length : lastIndex;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        endIndex - startIndex,
            (index) {
          final currentIndex = startIndex + index;
          final selectedMensaDay = mensaDays[currentIndex];

          return BlocConsumer<MensaCurrentDayCubit, MensaDay>(
            bloc: _mensaCurrentDayCubit,
            listener: (_, currentMensaDay) {
              final weekViewPageIndex = (mensaDays.indexWhere((day) => day.isEqualTo(currentMensaDay)) / 5).floor();
              if (weekViewPageIndex != pageController.page?.round()) {
                pageController.animateToPage(
                  weekViewPageIndex,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
              }
            },
            buildWhen: (previous, current) => current == selectedMensaDay || previous == selectedMensaDay,
            builder: (_, currentMensaDay) {
              return _buildDayItem(
                selectedMensaDay: selectedMensaDay,
                currentMensaDay: currentMensaDay,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDayItem({
    required MensaDay selectedMensaDay,
    required MensaDay currentMensaDay,
  }) {
    return GestureDetector(
      onTap: () => _mensaCurrentDayCubit.setCurrentMensaDay(newMensaDay: selectedMensaDay),
      child: _WeekViewItem(
        title: selectedMensaDay.toString(),
        isActive: selectedMensaDay.isEqualTo(currentMensaDay),
      ),
    );
  }
}

class _WeekViewItem extends StatelessWidget {
  const _WeekViewItem({
    required this.title,
    required this.isActive,
  });

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? context.colors.neutralColors.backgroundColors.weakColors.active : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: JoyText(
            title,
            weight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
