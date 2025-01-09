import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
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
    return Column(
      children: [
        const SizedBox(height: LmuSizes.size_4),
        LmuUnderlineTabBar(
          hasDivider: true,
          activeTabIndexNotifier: _activeTabIndexNotifier,
          items: const [
            LmuUnderlineTabBarItemData(title: "Overview"),
            LmuUnderlineTabBarItemData(title: "News"),
            LmuUnderlineTabBarItemData(title: "Uni Kino"),
            LmuUnderlineTabBarItemData(title: "Groups"),
          ],
          onTabChanged: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              _activeTabIndexNotifier.value = index;
            },
            children: [
              _buildOverviewTab(),
              _buildNewsTab(),
              _buildUniKinoTab(),
              _buildGroupsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewTab() { return HomeOverviewView(homeData: widget.homeData); }
  Widget _buildNewsTab() => const Center(child: Text('News Content Coming Soon..'));
  Widget _buildUniKinoTab() => const Center(child: Text('Uni Kino Content Coming Soon..'));
  Widget _buildGroupsTab() => const Center(child: Text('Groups Content Coming Soon..'));
}
