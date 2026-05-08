import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'link_card_loading.dart';

class LinksLoadingView extends StatelessWidget {
  const LinksLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: LmuSkeleton(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: LmuSizes.size_16),
              LmuTileHeadline.base(title: BoneMock.chars(2)),
              LmuContentTile(contentList: List.generate(2, (index) => const LinkCardLoading())),
              const SizedBox(height: LmuSizes.size_24),
              LmuTileHeadline.base(title: BoneMock.chars(4)),
              LmuButtonRow(
                hasHorizontalPadding: false,
                buttons: [
                  LmuIconButton(
                    icon: LucideIcons.search,
                    onPressed: () => {},
                  ),
                  LmuButton(
                    title: BoneMock.chars(4),
                    emphasis: ButtonEmphasis.secondary,
                    onTap: () => {},
                  ),
                  LmuButton(
                    title: BoneMock.chars(4),
                    emphasis: ButtonEmphasis.secondary,
                    onTap: () => {},
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuTileHeadline.base(title: BoneMock.chars(2)),
              const LmuContentTile(content: LinkCardLoading()),
              const SizedBox(height: LmuSizes.size_16),
              LmuTileHeadline.base(title: BoneMock.chars(2)),
              LmuContentTile(contentList: List.generate(2, (index) => const LinkCardLoading())),
              const SizedBox(height: LmuSizes.size_16),
              LmuTileHeadline.base(title: BoneMock.chars(2)),
              const LmuContentTile(content: LinkCardLoading()),
              const SizedBox(height: LmuSizes.size_16),
              LmuTileHeadline.base(title: BoneMock.chars(2)),
              LmuContentTile(contentList: List.generate(2, (index) => const LinkCardLoading())),
              const SizedBox(height: LmuSizes.size_16),
              LmuTileHeadline.base(title: BoneMock.chars(2)),
              const LmuContentTile(content: LinkCardLoading()),
              const SizedBox(height: LmuSizes.size_16),
              LmuTileHeadline.base(title: BoneMock.chars(2)),
              LmuContentTile(contentList: List.generate(2, (index) => const LinkCardLoading())),
              const SizedBox(height: LmuSizes.size_96),
            ],
          ),
        ),
      ),
    );
  }
}
