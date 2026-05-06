import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/models/club.dart';
import '../viewmodel/club_detail_page_driver.dart';

class ClubDetailPage extends DrivableWidget<ClubDetailPageDriver> {
  ClubDetailPage({super.key, required this.club});

  final Club club;

  bool get _hasExternalLink => club.instagramUrl != null || club.linkedinUrl != null || club.url != null;

  @override
  Widget build(BuildContext context) {
    final club = driver.club;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: club.title,
        largeTitleTrailingWidget: club.logoUrl != null ? LmuInListImage(imageUrl: club.logoUrl!) : null,
        leadingAction: LeadingAction.back,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: LmuSizes.size_16,
          right: LmuSizes.size_16,
          top: LmuSizes.size_16,
          bottom: LmuSizes.size_96,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (club.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: LmuSizes.size_16),
                child: LmuText.body(
                  club.description,
                ),
              ),
            if (_hasExternalLink)
              Padding(
                padding: const EdgeInsets.only(bottom: LmuSizes.size_24),
                child: LmuButtonRow(
                  hasHorizontalPadding: false,
                  buttons: [
                    if (club.url != null)
                      LmuButton(
                        title: 'Website',
                        emphasis: ButtonEmphasis.secondary,
                        onTap: () => LmuUrlLauncher.launchWebsite(
                          url: club.url!,
                          context: context,
                        ),
                      ),
                    if (club.instagramUrl != null)
                      LmuButton(
                        title: 'Instagram',
                        emphasis: ButtonEmphasis.secondary,
                        onTap: () => LmuUrlLauncher.launchWebsite(
                          url: club.instagramUrl!,
                          context: context,
                        ),
                      ),
                    if (club.linkedinUrl != null)
                      LmuButton(
                        title: 'LinkedIn',
                        emphasis: ButtonEmphasis.secondary,
                        onTap: () => LmuUrlLauncher.launchWebsite(
                          url: club.linkedinUrl!,
                          context: context,
                        ),
                      ),
                  ],
                ),
              ),
            if (club.content != null && club.content!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: LmuSizes.size_24),
                child: ExpandableText(
                  text: club.content!,
                  maxLines: 5,
                  amountOfHorizontalPadding: LmuSizes.size_32,
                ),
              ),
            if (club.email != null && club.email!.isNotEmpty)
              LmuContentTile(
                content: LmuListItem.base(
                  title: context.locals.clubs.email,
                  subtitle: club.email,
                  leadingArea: const LeadingFancyIcons(icon: LucideIcons.mail),
                  trailingArea: LmuIconButton(
                    icon: LucideIcons.copy,
                    onPressed: () => CopyToClipboardUtil.copyToClipboard(
                      context: context,
                      copiedText: club.email!,
                      message: "Copied email address",
                    ),
                  ),
                  onTap: () => LmuUrlLauncher.launchWebsite(
                    context: context,
                    url: 'mailto:${club.email!}',
                    mode: LmuUrlLauncherMode.externalApplication,
                  ),
                ),
              ),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<ClubDetailPageDriver> get driverProvider => $ClubDetailPageDriverProvider(
        club: club,
      );
}
