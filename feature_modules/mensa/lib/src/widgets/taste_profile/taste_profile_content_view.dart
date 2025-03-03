import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../repository/api/models/taste_profile/taste_profile.dart';
import '../../services/taste_profile_service.dart';
import 'taste_profile_footer_section.dart';
import 'taste_profile_labels_section.dart';
import 'taste_profile_presets_section.dart';
import 'taste_profile_title_section.dart';
import 'taste_profile_toggle_section.dart';

class TasteProfileContentView extends StatelessWidget {
  const TasteProfileContentView({super.key, required this.tasteProfileModel});

  final TasteProfileModel tasteProfileModel;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: PrimaryScrollController.of(context),
      slivers: [
        const SliverToBoxAdapter(child: TasteProfileTitleSection()),
        const SliverToBoxAdapter(child: TasteProfileToggleSection()),
        SliverToBoxAdapter(child: TasteProfilePresetsSection(tasteProfileModel: tasteProfileModel)),
        const SliverToBoxAdapter(child: _LabelsHeader()),
        TasteProfileLabelsSection(tasteProfileModel: tasteProfileModel),
        const SliverToBoxAdapter(child: TasteProfileFooterSection()),
      ],
    );
  }
}

class _LabelsHeader extends StatelessWidget {
  const _LabelsHeader();

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.canteen;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: LmuTileHeadline.action(
        title: localizations.tastePreferences,
        actionTitle: localizations.reset,
        onActionTap: GetIt.I.get<TasteProfileService>().reset,
      ),
    );
  }
}
