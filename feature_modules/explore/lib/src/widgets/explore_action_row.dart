import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../../explore.dart';
import '../extensions/explore_marker_type_extension.dart';
import '../services/explore_map_service.dart';
import 'explore_map_dot.dart';

class ExploreActionRow extends StatelessWidget {
  const ExploreActionRow({super.key});

  @override
  Widget build(BuildContext context) {
    final mapService = GetIt.I<ExploreMapService>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
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
        valueListenable: mapService.exploreLocationFilterNotifier,
        builder: (context, activeFilters, child) {
          return LmuButtonRow(
            buttons: [
              LmuButton(
                title: context.locals.app.search,
                leadingIcon: LucideIcons.search,
                emphasis: ButtonEmphasis.secondary,
                onTap: () => const ExploreSearchRoute().go(context),
              ),
              ...ExploreLocationFilter.values.map(
                (val) {
                  final isActive = activeFilters.contains(val);
                  return LmuButton(
                    leadingWidget: _getIconWidget(context.colors, val),
                    title: _labelForFilter(context.locals, val),
                    emphasis: isActive ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
                    action: isActive ? ButtonAction.contrast : ButtonAction.base,
                    onTap: () => mapService.updateFilter(val),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }

  String _labelForFilter(LmuLocalizations locals, ExploreLocationFilter filter) {
    switch (filter) {
      case ExploreLocationFilter.mensa:
        return locals.canteen.canteens;
      case ExploreLocationFilter.building:
        return locals.roomfinder.buildings;
      case ExploreLocationFilter.cinema:
        return locals.cinema.cinemasTitle;
      case ExploreLocationFilter.library:
        return locals.libraries.pageTitle;
    }
  }

  Widget? _getIconWidget(LmuColors colors, ExploreLocationFilter filter) {
    final exploreMarkerTypes = () {
      if (filter == ExploreLocationFilter.building) {
        return [
          ExploreMarkerType.roomfinderBuilding,
        ];
      } else if (filter == ExploreLocationFilter.mensa) {
        return [
          ExploreMarkerType.mensaMensa,
          ExploreMarkerType.mensaStuBistro,
          ExploreMarkerType.mensaStuCafe,
          ExploreMarkerType.mensaStuLounge,
        ];
      } else if (filter == ExploreLocationFilter.cinema) {
        return [
          ExploreMarkerType.cinema,
        ];
      } else if (filter == ExploreLocationFilter.library) {
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
