import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:shared_api/mensa.dart';

import '../../../repository/api/models/menu/menu_day_model.dart';
import '../menu/menu_day_entry.dart';

class MenuContentView extends StatefulWidget {
  const MenuContentView({
    super.key,
    required this.menuModels,
    required this.mensaType,
  });

  final List<MenuDayModel> menuModels;
  final MensaType mensaType;

  @override
  State<MenuContentView> createState() => _MenuContentViewState();
}

class _MenuContentViewState extends State<MenuContentView> {
  late PageController _pageController;
  late ValueNotifier<int> _tabNotifier;
  late bool isTemporarilyClosed;

  MensaType get _mensaType => widget.mensaType;

  @override
  void initState() {
    super.initState();
    const initialIndex = 0;
    _pageController = PageController(initialPage: initialIndex);
    _tabNotifier = ValueNotifier<int>(initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: LmuTabBar(
        activeTabIndexNotifier: _tabNotifier,
        hasDivider: true,
        items: widget.menuModels.map(
          (dayModel) {
            final dateTime = DateTime.parse(dayModel.date);
            final isLastDayOfWeek = dateTime.weekday == 5;
            return LmuTabBarItemData(
              title: dateTime.dayName(context.locals.app),
              trailingWidget: dayModel.isClosed ? const LmuStatusDot(statusColor: StatusColor.red) : null,
              hasDivider: isLastDayOfWeek,
            );
          },
        ).toList(),
        onTabChanged: (index, _) => _pageController.jumpToPage(index),
      ),
      sliver: SliverToBoxAdapter(
        child: ExpandablePageView.builder(
          animationDuration: const Duration(milliseconds: 200),
          itemCount: widget.menuModels.length,
          controller: _pageController,
          animationCurve: Curves.bounceIn,
          onPageChanged: (index) {
            _tabNotifier.value = index;
          },
          itemBuilder: (_, index) {
            return MenuDayEntry(
              mensaMenuModel: widget.menuModels[index],
              mensaType: _mensaType,
            );
          },
        ),
      ),
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
      localizations.saturday,
      localizations.sunday,
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
