import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core_routes/explore.dart';
import 'package:core_routes/roomfinder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/enums/roomfinder_sort_option.dart';
import '../services/roomfinder_filter_service.dart';

class RoomfinderButtonSection extends StatefulWidget {
  const RoomfinderButtonSection({super.key});

  @override
  State<RoomfinderButtonSection> createState() => _RoomfinderButtonSectionState();
}

class _RoomfinderButtonSectionState extends State<RoomfinderButtonSection> {
  late final ValueNotifier<RoomfinderSortOption> _sortOptionNotifier;

  final _roomfinderFilterService = GetIt.I.get<RoomfinderFilterService>();

  @override
  void initState() {
    super.initState();
    _sortOptionNotifier = _roomfinderFilterService.sortOptionNotifier;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LmuTileHeadline.base(title: context.locals.roomfinder.allBuildings),
        Row(
          children: [
            LmuMapImageButton(onTap: () => const ExploreMainRoute(filter: 'building').go(context)),
            const SizedBox(width: LmuSizes.size_8),
            LmuIconButton(
              icon: LucideIcons.search,
              onPressed: () => const RoomfinderSearchRoute().go(context),
            ),
            const SizedBox(width: LmuSizes.size_8),
            ValueListenableBuilder(
              valueListenable: _sortOptionNotifier,
              builder: (context, sortOption, child) {
                return LmuButton(
                  title: sortOption.localizedName(context.locals.roomfinder),
                  emphasis: ButtonEmphasis.secondary,
                  trailingIcon: LucideIcons.chevron_down,
                  onTap: () {
                    LmuBottomSheet.show(
                      context,
                      content: _RoomfinderSortOptionSheet(
                        sortOptionNotifier: _sortOptionNotifier,
                        roomfinderFilterService: _roomfinderFilterService,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        const SizedBox(height: LmuSizes.size_24),
      ],
    );
  }
}

class _RoomfinderSortOptionSheet extends StatelessWidget {
  const _RoomfinderSortOptionSheet({
    required ValueNotifier<RoomfinderSortOption> sortOptionNotifier,
    required RoomfinderFilterService roomfinderFilterService,
  })  : _sortOptionNotifier = sortOptionNotifier,
        _roomfinderFilterService = roomfinderFilterService;

  final ValueNotifier<RoomfinderSortOption> _sortOptionNotifier;
  final RoomfinderFilterService _roomfinderFilterService;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _sortOptionNotifier,
      builder: (context, activeSortOption, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: RoomfinderSortOption.values.map(
            (option) {
              final isActive = option == activeSortOption;
              final textColor = option.textColor(context.colors, isActive: isActive);
              final isLast = option.index == RoomfinderSortOption.values.length - 1;
              final name = option.localizedName(context.locals.roomfinder);
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : LmuSizes.size_8),
                child: LmuListItem.base(
                  title: isActive ? name : null,
                  titleColor: textColor,
                  subtitle: isActive ? null : name,
                  leadingArea: LmuIcon(
                    icon: option.icon,
                    size: LmuIconSizes.medium,
                    color: textColor,
                  ),
                  onTap: () async {
                    if (option == RoomfinderSortOption.distance) {
                      final hasPermission = await _roomfinderFilterService.hasLocationPermission();
                      if (!hasPermission && context.mounted) {
                        await PermissionsService.showLocationPermissionDeniedDialog(context);
                        return;
                      }
                    }

                    _roomfinderFilterService.updateSortOption(option);
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () {
                        if (context.mounted) {
                          Navigator.of(context, rootNavigator: true).pop();
                        }
                      },
                    );
                  },
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}

extension on RoomfinderSortOption {
  IconData get icon {
    return switch (this) {
      RoomfinderSortOption.alphabetically => LucideIcons.a_large_small,
      RoomfinderSortOption.distance => LucideIcons.arrow_right_from_line,
    };
  }

  String localizedName(RoomfinderLocatizations locals) {
    return switch (this) {
      RoomfinderSortOption.alphabetically => locals.alphabetical,
      RoomfinderSortOption.distance => locals.distance,
    };
  }

  Color textColor(LmuColors colors, {required bool isActive}) {
    if (isActive) {
      return colors.brandColors.textColors.strongColors.base;
    }
    return colors.neutralColors.textColors.mediumColors.base;
  }
}
