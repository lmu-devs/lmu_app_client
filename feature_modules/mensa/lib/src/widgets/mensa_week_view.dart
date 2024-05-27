import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/bloc/mensa_current_day_cubit/mensa_current_day_cubit.dart';
import 'package:mensa/src/utils/get_mensa_days.dart';
import 'package:mensa/src/utils/mensa_day.dart';

class MensaWeekView extends StatelessWidget {
  MensaWeekView({
    super.key,
    required this.mensaCurrentDayCubit,
    required this.weekViewController,
    this.hasDivider = true,
  }) : mensaDays = getMensaDays(excludeWeekend: true);

  final MensaCurrentDayCubit mensaCurrentDayCubit;
  final PageController weekViewController;
  final bool hasDivider;
  final List<MensaDay> mensaDays;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 36,
          margin: const EdgeInsets.all(12),
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(),
            controller: weekViewController,
            itemCount: (mensaDays.length / 5).ceil(),
            itemBuilder: (context, rowIndex) {
              int startIndex = rowIndex * 5;
              int endIndex = (rowIndex + 1) * 5;
              if (endIndex > mensaDays.length) {
                endIndex = mensaDays.length;
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  endIndex - startIndex,
                  (index) {
                    int currentIndex = startIndex + index;
                    return GestureDetector(
                      onTap: () {
                        mensaCurrentDayCubit.setCurrentMensaDay(newMensaDay: mensaDays[currentIndex]);
                      },
                      child: BlocBuilder<MensaCurrentDayCubit, MensaDay>(
                        bloc: mensaCurrentDayCubit,
                        builder: (context, currentMensaDay) {
                          if (!mensaDays.contains(currentMensaDay)) {
                            for (MensaDay day in mensaDays) {
                              if (day.isAfter(currentMensaDay)) {
                                currentMensaDay = day;
                                break;
                              }
                            }
                          }
                          return _WeekViewItem(
                            currentMensaDay: mensaCurrentDayCubit.state,
                            selectedMensaDay: mensaDays[currentIndex],
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        if (hasDivider) const Divider(thickness: 0.5, height: 0),
      ],
    );
  }
}

class _WeekViewItem extends StatelessWidget {
  const _WeekViewItem({
    required this.currentMensaDay,
    required this.selectedMensaDay,
  });

  final MensaDay currentMensaDay;
  final MensaDay selectedMensaDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selectedMensaDay.isEqualTo(currentMensaDay)
            ? context.colors.neutralColors.backgroundColors.weakColors.active
            : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: JoyText(
            selectedMensaDay.toString(),
            weight: selectedMensaDay.isEqualTo(currentMensaDay) ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
