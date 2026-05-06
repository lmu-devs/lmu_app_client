import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';

class ClubsPageLoading extends StatelessWidget {
  const ClubsPageLoading({super.key});

  final _categoryLoadingCount = 6;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: LmuSizes.size_16),
        const LmuContentTile(
          content: LmuListItemLoading(
            titleLength: 2,
            action: LmuListItemAction.chevron,
          ),
        ),
        const SizedBox(height: LmuSizes.size_16),
        LmuContentTile(
          contentList: List.generate(
            _categoryLoadingCount,
            (index) => LmuListItemLoading(
              titleLength: 3,
              subtitleLength: 4,
              action: LmuListItemAction.chevron,
              hasDivier: index != _categoryLoadingCount - 1,
            ),
          ),
        ),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }
}
