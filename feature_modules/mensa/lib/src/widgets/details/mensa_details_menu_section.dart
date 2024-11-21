import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/menu_cubit/cubit.dart';
import '../../views/views.dart';

class MensaDetailsMenuSection extends StatefulWidget {
  const MensaDetailsMenuSection({super.key});

  @override
  State<MensaDetailsMenuSection> createState() => _MensaDetailsMenuSectionState();
}

class _MensaDetailsMenuSectionState extends State<MensaDetailsMenuSection> {
  final _pageController = PageController();
  final _tabNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        if (state is! MenuLoadSuccess) {
          return const MenuLoadingView();
        }
        final menuModels = state.menuModels;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LmuTabBar(
              activeTabIndexNotifier: _tabNotifier,
              items: menuModels.map(
                (dayModel) {
                  final dateTime = DateTime.parse(dayModel.date);
                  return LmuTabBarItemData(
                    title: dateTime.dayName(context.locals.app),
                  );
                },
              ).toList(),
              onTabChanged: (index, _) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            Divider(
              height: 0.5,
              color: colors.neutralColors.borderColors.seperatorLight,
            ),
            SizedBox(
              height: 1000,
              child: PageView.builder(
                itemCount: menuModels.length,
                controller: _pageController,
                onPageChanged: (index) {
                  _tabNotifier.value = index;
                },
                itemBuilder: (_, index) {
                  return MenuContentView(
                    mensaMenuModel: menuModels[index],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

extension DateTimeName on DateTime {
  String dayName(AppLocalizations localizations) {
    final weekdays = [
      localizations.monday,
      localizations.tuesday,
      localizations.wednesday,
      localizations.thursday,
      localizations.friday,
    ];

    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));

    if (_isSameDate(today)) {
      return localizations.today;
    } else if (_isSameDate(tomorrow)) {
      return localizations.tomorrow;
    }

    final weekdayName = weekdays[weekday - 1];
    return '${weekdayName.substring(0, 2)}. $day';
  }

  bool _isSameDate(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }
}
