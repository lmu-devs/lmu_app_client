import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/cinema.dart';

import '../repository/api/models/home_model.dart';
import 'home_overview_view.dart';

class HomeSuccessView extends StatefulWidget {
  const HomeSuccessView({
    super.key,
    required this.homeData,
  });

  final HomeModel homeData;

  @override
  State<HomeSuccessView> createState() => _HomeSuccessViewState();
}

class _HomeSuccessViewState extends State<HomeSuccessView> {
  final ValueNotifier<int> _activeTabIndexNotifier = ValueNotifier(0);
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _activeTabIndexNotifier.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverStickyHeader(
          header: LmuUnderlineTabBar(
            activeTabIndexNotifier: _activeTabIndexNotifier,
            hasDivider: true,
            items: [
              LmuUnderlineTabBarItemData(title: context.locals.home.overviewTab),
              LmuUnderlineTabBarItemData(title: context.locals.home.newsTab),
              LmuUnderlineTabBarItemData(title: context.locals.home.moviesTab),
              LmuUnderlineTabBarItemData(title: context.locals.home.groupTab),
            ],
            onTabChanged: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  _activeTabIndexNotifier.value = index;
                },
                children: [
                  _buildOverviewTab(),
                  _buildNewsTab(),
                  _buildMoviesTab(),
                  _buildGroupsTab(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewTab() => HomeOverviewView(homeData: widget.homeData);

  Widget _buildNewsTab() => Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(LucideIcons.construction, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            LmuText.body(
              "This tab is work in progress",
              color: Colors.grey,
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 8),
            const Icon(LucideIcons.construction, size: 16, color: Colors.grey),
          ],
        ),
      );

  Widget _buildMoviesTab() => GetIt.I.get<CinemaService>().cinemaPage;

  Widget _buildGroupsTab() => Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(LucideIcons.construction, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            LmuText.body(
              "This tab is work in progress",
              color: Colors.grey,
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 8),
            const Icon(LucideIcons.construction, size: 16, color: Colors.grey),
          ],
        ),
      );
}
