import 'package:collection/collection.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:go_router/go_router.dart';
import 'package:core/localizations.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    required this.children,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      body: AnimatedBranchContainer(
        currentIndex: navigationShell.currentIndex,
        children: children,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: context.colors.neutralColors.borderColors.seperatorLight,
                width: 1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor:
                context.colors.neutralColors.textColors.strongColors.base,
            unselectedItemColor:
                context.colors.neutralColors.textColors.weakColors.base,
            backgroundColor: context.colors.neutralColors.backgroundColors.base,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: const Icon(LucideIcons.utensils), label: context.locals.canteen.tabTitle),
              BottomNavigationBarItem(
                  icon: const Icon(LucideIcons.map), label: context.locals.explore.tabTitle),
              BottomNavigationBarItem(
                  icon: const Icon(LucideIcons.circle_ellipsis), label: context.locals.settings.tabTitle),
            ],
            currentIndex: navigationShell.currentIndex,
            onTap: (int index) => _onTap(context, index),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    LmuVibrations.vibrate(type: VibrationType.secondary);
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class AnimatedBranchContainer extends StatelessWidget {
  const AnimatedBranchContainer(
      {super.key, required this.currentIndex, required this.children});

  final int currentIndex;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: children.mapIndexed(
      (int index, Widget navigator) {
        return AnimatedOpacity(
          opacity: index == currentIndex ? 1 : 0,
          duration: const Duration(milliseconds: 100),
          child: _branchNavigatorWrapper(index, navigator),
        );
      },
    ).toList());
  }

  Widget _branchNavigatorWrapper(int index, Widget navigator) => IgnorePointer(
        ignoring: index != currentIndex,
        child: TickerMode(
          enabled: index == currentIndex,
          child: navigator,
        ),
      );
}
