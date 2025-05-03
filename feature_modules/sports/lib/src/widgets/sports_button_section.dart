import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/sports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../services/sports_state_service.dart';

class SportsButtonSection extends StatefulWidget {
  const SportsButtonSection({super.key});

  @override
  State<SportsButtonSection> createState() => _SportsButtonSectionState();
}

class _SportsButtonSectionState extends State<SportsButtonSection> {
  bool _isAvailableActive = false;
  @override
  Widget build(BuildContext context) {
    final locals = context.locals.app;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        children: [
          LmuTileHeadline.base(title: context.locals.sports.sportOverviewTitle),
          Row(
            children: [
              LmuIconButton(
                icon: LucideIcons.search,
                onPressed: () => const SportsSearchRoute().go(context),
              ),
              const SizedBox(width: LmuSizes.size_8),
              LmuButton(
                title: locals.available,
                emphasis: _isAvailableActive ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
                action: _isAvailableActive ? ButtonAction.contrast : ButtonAction.base,
                onTap: () {
                  GetIt.I.get<SportsStateService>().applyFilter(
                        _isAvailableActive ? SportsFilterOption.available : SportsFilterOption.all,
                      );
                  setState(() {
                    _isAvailableActive = !_isAvailableActive;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: LmuSizes.size_16),
        ],
      ),
    );
  }
}
