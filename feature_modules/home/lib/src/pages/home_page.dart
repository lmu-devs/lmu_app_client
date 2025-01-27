import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/settings.dart';

import 'for_you_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ValueNotifier<int> _activeTabIndexNotifier;
  late final PageController _pageController;
  final _tabs = ["For You", "News", "Movies"];

  @override
  void initState() {
    _activeTabIndexNotifier = ValueNotifier(0);
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _activeTabIndexNotifier,
      builder: (context, value, child) {
        return LmuMasterAppBar.custom(
          collapsedTitle: _tabs[value],
          largeTitleTrailingWidget: GestureDetector(
            onTap: () => GetIt.I.get<SettingsService>().navigateToSettings(context),
            child: const LmuIcon(icon: LucideIcons.settings, size: LmuIconSizes.medium),
          ),
          customLargeTitleWidget: LmuTabBar(
            activeTabIndexNotifier: _activeTabIndexNotifier,
            hasDefaultPaddings: false,
            items: _tabs.map((e) => LmuTabBarItemData(title: e)).toList(),
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
              const ForYouPage(),
              const _PlaceholderPage(),
              GetIt.I.get<CinemaService>().cinemaPage,
            ],
          ),
        ],
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage();

  @override
  Widget build(BuildContext context) {
    final textColor = context.colors.neutralColors.textColors.mediumColors.base;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: LmuSizes.size_16),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: LmuSizes.size_8),
              Icon(LucideIcons.construction, size: LmuIconSizes.small, color: textColor),
              const SizedBox(width: LmuSizes.size_8),
              LmuText.body(
                "This tab is work in progress",
                color: textColor,
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: LmuSizes.size_8),
              Icon(LucideIcons.construction, size: LmuIconSizes.small, color: textColor),
            ],
          ),
        ],
      ),
    );
  }
}
