import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'link_card_loading.dart';

class LinksLoadingView extends StatelessWidget {
  const LinksLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LmuMasterAppBar(
        largeTitle: "Links",
        leadingAction: LeadingAction.back,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: LmuSkeleton(
              child: Column(
                children: [
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
        ),
      ),
    );
  }
}
