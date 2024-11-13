import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';
import 'package:super_cupertino_navigation_bar/models/super_appbar.model.dart';
import 'package:super_cupertino_navigation_bar/utils/hero_things.dart';
import 'package:super_cupertino_navigation_bar/utils/measures.dart';
import 'package:super_cupertino_navigation_bar/utils/navigation_bar_static_components.dart';
import 'package:super_cupertino_navigation_bar/utils/persistent_nav_bar.dart';
import 'package:super_cupertino_navigation_bar/utils/store.dart';

class SuperScaffold extends StatefulWidget {
  SuperScaffold({
    Key? key,
    required this.appBar,
    this.stretch = true,
    this.body = const SizedBox(),
    this.onCollapsed,
    this.brightness,
    this.scrollController,
    this.transitionBetweenRoutes = true,
  }) : super(key: key) {
    measures = Measures(
      searchTextFieldHeight: 40, //DELETE
      largeTitleContainerHeight: appBar.largeTitle!.height,
      primaryToolbarHeight: appBar.height,
      bottomToolbarHeight: 0, //DELETE
      searchBarAnimationDurationx: const Duration(milliseconds: 250), //DELETE
    );
  }

  final bool stretch;

  final bool transitionBetweenRoutes;

  final Brightness? brightness;

  late final Measures measures;

  final SuperAppBar appBar;

  final Widget body;

  final Function(bool)? onCollapsed;
  late final ScrollController? scrollController;

  @override
  State<SuperScaffold> createState() => _SuperScaffoldState();
}

class _SuperScaffoldState extends State<SuperScaffold> {
  double _scrollOffset = 0;
  bool _collapsed = false;
  bool isSubmitted = false;
  late ScrollController _scrollController;
  late NavigationBarStaticComponentsKeys keys;

  @override
  void initState() {
    super.initState();
    keys = NavigationBarStaticComponentsKeys();
    _scrollController = widget.scrollController ?? ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(() {
        _scrollOffset = _scrollController.offset;
        Store.instance.scrollOffset.value = _scrollController.offset;
        checkIfCollapsed();
      });
    });
  }

  checkIfCollapsed() {
    if (_scrollOffset >= widget.measures.largeTitleContainerHeight + widget.appBar.largeTitle!.height) {
      if (!_collapsed) {
        if (widget.onCollapsed != null) {
          widget.onCollapsed!(true);
        }
        _collapsed = true;
      }
    } else {
      if (_collapsed) {
        if (widget.onCollapsed != null) {
          widget.onCollapsed!(false);
        }
        _collapsed = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final NavigationBarStaticComponents components = NavigationBarStaticComponents(
      keys: keys,
      route: ModalRoute.of(context),
      userLeading: widget.appBar.leading,
      automaticallyImplyLeading: widget.appBar.automaticallyImplyLeading,
      automaticallyImplyTitle: true,
      previousPageTitle: widget.appBar.previousPageTitle,
      userMiddle: widget.appBar.title,
      userTrailing: widget.appBar.actions,
      largeTitleActions: Row(children: [...?widget.appBar.largeTitle!.actions]),
      userLargeTitle: Text(
        widget.appBar.largeTitle!.largeTitle,
        style: widget.appBar.largeTitle!.textStyle.copyWith(
          color: widget.appBar.largeTitle!.textStyle.color ?? Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
      appbarBottom: widget.appBar.bottom!.child,
      padding: null,
      large: true,
    );

    final topPadding = MediaQuery.of(context).padding.top;
    final largeTitleContainerHeight = widget.measures.largeTitleContainerHeight;

    return Stack(
      children: [
        NestedScrollViewPlus(
          controller: _scrollController,
          physics: SnapScrollPhysics(
            parent: const BouncingScrollPhysics(),
            snaps: [
              Snap.avoidZone(0, widget.appBar.largeTitle!.height),
              Snap.avoidZone(
                  widget.appBar.largeTitle!.height, largeTitleContainerHeight + widget.appBar.largeTitle!.height),
            ],
          ),
          headerSliverBuilder: (_, __) => [
            OverlapAbsorberPlus(
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: topPadding + widget.measures.appbarHeight,
                ),
              ),
            )
          ],
          body: widget.body,
        ),
        ValueListenableBuilder(
          valueListenable: Store.instance.scrollOffset,
          builder: (context, scrollOffset, child) {
            final fullappbarheight = clampDouble(
                topPadding + widget.measures.appbarHeight - _scrollOffset,
                topPadding + widget.measures.primaryToolbarHeight + widget.appBar.bottom!.height,
                widget.stretch ? 3000 : topPadding + widget.measures.appbarHeight);

            final largeTitleHeight = (_scrollOffset > widget.appBar.largeTitle!.height
                ? clampDouble(largeTitleContainerHeight - (_scrollOffset - widget.appBar.largeTitle!.height), 0,
                    largeTitleContainerHeight)
                : largeTitleContainerHeight);

            double titleOpacity =
                (_scrollOffset >= (largeTitleContainerHeight) ? 1 : (largeTitleContainerHeight > 0 ? 0 : 1));

            double scaleTitle = _scrollOffset < 0 ? clampDouble((1 - _scrollOffset / 1500), 1, 1.12) : 1;

            if (!widget.stretch) scaleTitle = 1;
            if (widget.appBar.alwaysShowTitle) titleOpacity = 1;

            return Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: fullappbarheight,
              child: wrapWithBackground(
                border: widget.appBar.border,
                backgroundColor: widget.appBar.backgroundColor ?? Colors.transparent,
                brightness: widget.brightness,
                child: Builder(
                  builder: (context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: widget.measures.primaryToolbarHeight + topPadding,
                          child: PersistentNavigationBar(
                            components: components,
                            middleVisible: widget.appBar.alwaysShowTitle ? null : titleOpacity != 0,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            height: largeTitleHeight,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: largeTitleContainerHeight > 0 ? 8.0 : 0),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      children: [
                                        Transform.scale(
                                          scale: scaleTitle,
                                          filterQuality: FilterQuality.high,
                                          alignment: Alignment.bottomLeft,
                                          child: components.largeTitle, //largeTitle here
                                        ),
                                        const Spacer(),
                                        components.largeTitleActions!, // largeTitleActions here
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
