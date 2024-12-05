import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/menu_cubit/cubit.dart';
import '../../services/menu_service.dart';
import '../../views/views.dart';

class MensaDetailsMenuSection extends StatefulWidget {
  const MensaDetailsMenuSection({super.key, required this.canteenId});

  final String canteenId;

  @override
  State<MensaDetailsMenuSection> createState() => _MensaDetailsMenuSectionState();
}

class _MensaDetailsMenuSectionState extends State<MensaDetailsMenuSection> {
  late PageController _pageController;
  late ValueNotifier<int> _tabNotifier;

  String get _canteenId => widget.canteenId;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabNotifier = ValueNotifier<int>(0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      bloc: GetIt.I.get<MenuService>().getMenuCubit(_canteenId),
      builder: (context, state) {
        if (state is! MenuLoadSuccess) {
          return MenuLoadingView(canteendId: _canteenId);
        }

        final menuModels = state.menuModels;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                  curve: Curves.easeIn,
                );
              },
            ),
            const LmuDivider(),
            SizedBox(
              height: 1500,
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
            const SizedBox(height: LmuSizes.size_12),
          ],
        );
      },
    );
  }
}

extension _DateTimeName on DateTime {
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
