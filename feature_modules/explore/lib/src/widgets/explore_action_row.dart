import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core_routes/explore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../extensions/explore_marker_type_extension.dart';
import '../services/explore_location_service.dart';
import '../services/explore_map_service.dart';
import 'explore_map_dot.dart';

class ExploreActionRow extends StatelessWidget {
  const ExploreActionRow({super.key, required this.filterScrollController});

  final ScrollController filterScrollController;

  @override
  Widget build(BuildContext context) {
    final locationService = GetIt.I<ExploreLocationService>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_16),
      decoration: BoxDecoration(
        color: context.colors.neutralColors.backgroundColors.base,
        border: Border(
          top: BorderSide(
            color: context.colors.neutralColors.borderColors.seperatorLight,
            width: 1,
          ),
        ),
      ),
      child: ValueListenableBuilder(
        valueListenable: locationService.filterNotifier,
        builder: (context, activeFilters, child) {
          return LmuButtonRow(
            controller: filterScrollController,
            buttons: [
              LmuButton(
                title: context.locals.app.search,
                leadingIcon: LucideIcons.search,
                emphasis: ButtonEmphasis.secondary,
                onTap: () => const ExploreSearchRoute().go(context),
              ),
              ...ExploreFilterType.values.map(
                (val) {
                  final isActive = activeFilters.contains(val);
                  return LmuButton(
                    leadingWidget: _getIconWidget(context.colors, val),
                    title: _labelForFilter(context.locals, val),
                    emphasis: isActive ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
                    action: isActive ? ButtonAction.contrast : ButtonAction.base,
                    onTap: () => locationService.updateFilter(val),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }

  String _labelForFilter(LmuLocalizations locals, ExploreFilterType filter) {
    switch (filter) {
      case ExploreFilterType.mensa:
        return locals.canteen.canteens;
      case ExploreFilterType.building:
        return locals.roomfinder.buildings;
      case ExploreFilterType.library:
        return locals.libraries.pageTitle;
      case ExploreFilterType.cinema:
        return locals.cinema.cinemasTitle;
    }
  }

  Widget? _getIconWidget(LmuColors colors, ExploreFilterType filter) {
    final exploreMarkerTypes = () {
      if (filter == ExploreFilterType.building) {
        return [
          ExploreMarkerType.roomfinderBuilding,
        ];
      } else if (filter == ExploreFilterType.mensa) {
        return [
          ExploreMarkerType.mensaMensa,
          ExploreMarkerType.mensaStuBistro,
          ExploreMarkerType.mensaStuCafe,
          ExploreMarkerType.mensaStuLounge,
        ];
      } else if (filter == ExploreFilterType.cinema) {
        return [
          ExploreMarkerType.cinema,
        ];
      } else if (filter == ExploreFilterType.library) {
        return [
          ExploreMarkerType.library,
        ];
      }
    }();

    if (exploreMarkerTypes?.isEmpty ?? true) {
      return null;
    }

    return Stack(
      children: exploreMarkerTypes!
          .mapIndexed(
            (index, marker) => Padding(
              padding: EdgeInsets.only(
                left: index * 8.0,
              ),
              child: ExploreMapDot(
                dotColor: marker.markerColor(colors),
                icon: marker.icon,
                markerSize: ExploreMarkerSize.large,
              ),
            ),
          )
          .toList()
          .reversed
          .toList(),
    );
  }
}
