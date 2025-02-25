import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/settings.dart';
import 'package:shared_api/sports.dart';
import 'package:shared_api/timeline.dart';

import 'for_you_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ValueNotifier<int> _activeTabIndexNotifier;
  late final PageController _pageController;

  @override
  void initState() {
    _activeTabIndexNotifier = ValueNotifier(0);
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      context.locals.home.forYou,
      context.locals.sports.sportsTitle,
      context.locals.cinema.movie,
      context.locals.home.dates,
    ];

    return ValueListenableBuilder(
      valueListenable: _activeTabIndexNotifier,
      builder: (context, value, child) {
        return LmuMasterAppBar.custom(
          collapsedTitle: tabs[value],
          largeTitleTrailingWidget: GestureDetector(
            onTap: () => GetIt.I.get<SettingsService>().navigateToSettings(context),
            child: const LmuIcon(icon: LucideIcons.settings, size: LmuIconSizes.medium),
          ),
          customLargeTitleWidget: LmuTabBar(
            activeTabIndexNotifier: _activeTabIndexNotifier,
            hasDefaultPaddings: false,
            items: tabs.map((e) => LmuTabBarItemData(title: e)).toList(),
            onTabChanged: (index, _) => _pageController.jumpToPage(index),
          ),
          body: child!,
        );
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const LmuDivider(),
          PageView(
            controller: _pageController,
            onPageChanged: (index) => _activeTabIndexNotifier.value = index,
            children: [
              ForYouPage(pageController: _pageController),
              GetIt.I.get<SportsService>().sportsPage,
              GetIt.I.get<CinemaService>().cinemaPage,
              GetIt.I.get<TimelineService>().timelinePage,
            ],
          ),
        ],
      ),
    );
  }
}
