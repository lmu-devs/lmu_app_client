import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/models/club.dart';
import '../../domain/models/club_type.dart';
import '../viewmodel/club_detail_page_driver.dart';

class ClubDetailPage extends DrivableWidget<ClubDetailPageDriver> {
  ClubDetailPage({super.key, required this.club});

  final Club club;

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData.custom(
        leadingAction: LeadingAction.back,
        collapsedTitle: club.title,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (driver.hasImage) ...[
              Semantics(
                label: club.image!.name,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(LmuRadiusSizes.mediumLarge),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: LmuCachedNetworkImageProvider(
                        club.image!.url,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: LmuSizes.size_24),
            ],
            LmuText.h1(
              club.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: LmuSizes.size_24),
            LmuText.body(
              club.type.localizedName(context.locals.clubs),
              color: context.colors.neutralColors.textColors.mediumColors.base,
            ),
            if (driver.hasFoundingYear) ...[
              const SizedBox(height: LmuSizes.size_8),
              LmuText.body(
                context.locals.clubs.since(club.foundingYear!.toString()),
                color: context.colors.neutralColors.textColors.mediumColors.base,
              ),
            ],
            const SizedBox(height: LmuSizes.size_24),
            if (driver.hasExternalLink) ...[
              LmuButtonRow(
                hasHorizontalPadding: false,
                buttons: [
                  if (club.url != null)
                    LmuButton(
                      title: context.locals.clubs.website,
                      emphasis: ButtonEmphasis.secondary,
                      onTap: () => LmuUrlLauncher.launchWebsite(
                        url: club.url!,
                        context: context,
                      ),
                    ),
                  if (club.instagramUrl != null)
                    LmuButton(
                      title: context.locals.clubs.instagram,
                      emphasis: ButtonEmphasis.secondary,
                      onTap: () => LmuUrlLauncher.launchWebsite(
                        url: club.instagramUrl!,
                        context: context,
                      ),
                    ),
                  if (club.linkedinUrl != null)
                    LmuButton(
                      title: context.locals.clubs.linkedin,
                      emphasis: ButtonEmphasis.secondary,
                      onTap: () => LmuUrlLauncher.launchWebsite(
                        url: club.linkedinUrl!,
                        context: context,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_24),
            ],
            if (driver.hasLocation) ...[
              LmuListItem.base(
                subtitle: club.location?.address ?? '',
                subtitleTextColor: context.colors.neutralColors.textColors.mediumColors.base,
                hasHorizontalPadding: false,
                hasDivider: true,
                trailingArea: Icon(
                  LucideIcons.map,
                  size: LmuIconSizes.mediumSmall,
                  color: context.colors.neutralColors.textColors.weakColors.base,
                ),
                onTap: () => LmuBottomSheet.show(
                  context,
                  content: NavigationSheet(id: club.id, location: club.location!, showInAppMap: false),
                ),
              ),
              const SizedBox(height: LmuSizes.size_12),
            ],
            if (driver.hasContent) ...[
              LmuHtmlViewer(data: club.content!),
              const SizedBox(height: LmuSizes.size_32),
            ],
            if (driver.hasEmail)
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
                      message: context.locals.clubs.copiedEmail,
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
