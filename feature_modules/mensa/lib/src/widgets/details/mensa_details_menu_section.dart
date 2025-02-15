import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/mensa.dart';

import '../../bloc/menu_cubit/cubit.dart';
import '../../services/menu_service.dart';
import 'menu/loading/menu_loading_view.dart';
import 'menu/menu_content_view.dart';

class MensaDetailsMenuSection extends StatefulWidget {
  const MensaDetailsMenuSection({
    super.key,
    required this.canteenId,
    required this.mensaType,
  });

  final String canteenId;
  final MensaType mensaType;

  @override
  State<MensaDetailsMenuSection> createState() => _MensaDetailsMenuSectionState();
}

class _MensaDetailsMenuSectionState extends State<MensaDetailsMenuSection> {
  late PageController _pageController;
  late ValueNotifier<int> _tabNotifier;
  late bool isTemporarilyClosed;

  String get _canteenId => widget.canteenId;

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
    return BlocBuilder<MenuCubit, MenuState>(
      bloc: GetIt.I.get<MenuService>().getMenuCubit(_canteenId),
      builder: (context, state) {
        if (state is! MenuLoadSuccess) {
          return MenuLoadingView(canteendId: _canteenId);
        }

        final menuModels = state.menuModels;
        return SliverStickyHeader(
          header: LmuTabBar(
            activeTabIndexNotifier: _tabNotifier,
            hasDivider: true,
            items: menuModels.map(
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
              itemCount: menuModels.length,
              controller: _pageController,
              animationCurve: Curves.bounceIn,
              onPageChanged: (index) {
                _tabNotifier.value = index;
              },
              itemBuilder: (_, index) {
                return MenuContentView(
                  mensaMenuModel: menuModels[index],
                  mensaType: widget.mensaType,
                );
              },
            ),
          ),
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
      localizations.saturady,
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
