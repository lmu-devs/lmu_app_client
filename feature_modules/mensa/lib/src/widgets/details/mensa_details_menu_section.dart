import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/menu_cubit/cubit.dart';
import '../../extensions/opening_hours_extensions.dart';
import '../../services/menu_service.dart';
import '../../views/views.dart';

class MensaDetailsMenuSection extends StatefulWidget {
  const MensaDetailsMenuSection({
    super.key,
    required this.canteenId,
    required this.mensaStatus,
  });

  final String canteenId;
  final Status mensaStatus;

  @override
  State<MensaDetailsMenuSection> createState() => _MensaDetailsMenuSectionState();
}

class _MensaDetailsMenuSectionState extends State<MensaDetailsMenuSection> {
  late PageController _pageController;
  late ValueNotifier<int> _tabNotifier;
  late StickyHeaderController _stickyHeaderController;

  String get _canteenId => widget.canteenId;

  @override
  void initState() {
    super.initState();
    const initialIndex = 0; //widget.mensaStatus == MensaStatus.closed ? 1 : 0;
    _pageController = PageController(initialPage: initialIndex);
    _tabNotifier = ValueNotifier<int>(initialIndex);
    _stickyHeaderController = StickyHeaderController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabNotifier.dispose();
    _stickyHeaderController.dispose();
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
          sticky: true,
          controller: _stickyHeaderController,
          header: LmuTabBar(
            activeTabIndexNotifier: _tabNotifier,
            hasDivider: true,
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
