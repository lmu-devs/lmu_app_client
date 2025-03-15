import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lucide_icons_svg/lucide_icons_svg.dart';

import '../service/home_preferences_service.dart';

class TuitionFeeWidget extends StatelessWidget {
  const TuitionFeeWidget({
    super.key,
  });

  String _getSemester(DateTime date, HomeLocalizations locals) {
    return date.month >= 8 ? locals.winter : locals.summer;
  }

  @override
  Widget build(BuildContext context) {
    final preferenceServie = GetIt.I.get<HomePreferencesService>();
    final endDate = DateTime.now();

    if (DateTime.now().isAfter(endDate)) {
      return const SizedBox.shrink();
    }

    return ValueListenableBuilder<bool>(
      valueListenable: preferenceServie.tuitionPayed,
      builder: (context, isPayed, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: LmuAnimations.slowSmooth,
                switchOutCurve: LmuAnimations.slowSmooth.flipped,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: isPayed
                    ? LmuContentTile(
                        key: const ValueKey('payed'),
                        content: LmuListItem.base(
                          title: context.locals.home.tuitionFeePayed(
                            _getSemester(DateTime.now(), context.locals.home),
                            DateTime.now().year,
                          ),
                          titleColor: context.colors.successColors.textColors.strongColors.base,
                          trailingArea: LmuCheckboxAction(
                            isActive: isPayed,
                          ),
                          mainContentAlignment: MainContentAlignment.center,
                          onTap: () async {
                            preferenceServie.setTuitionPayed(!isPayed);
                          },
                        ),
                      )
                    : LmuContentTile(
                        key: const ValueKey('not_payed'),
                        contentTileType: ContentTileType.top,
                        content: LmuListItem.base(
                          title: context.locals.home.tuitionFeeCountdown(
                            CountdownUtil.getRemainingTime(
                              context.locals.app,
                              DateTime.now(),
                              endDate,
                            ),
                          ),
                          trailingArea: LmuCheckboxAction(
                            isActive: isPayed,
                          ),
                          mainContentAlignment: MainContentAlignment.center,
                          onTap: () async {
                            preferenceServie.setTuitionPayed(!isPayed);
                          },
                        ),
                      ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: LmuAnimations.slowSmooth,
              switchOutCurve: LmuAnimations.slowSmooth.flipped,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    child: child,
                  ),
                );
              },
              child: !isPayed
                  ? Padding(
                      key: ValueKey('bottom_content$isPayed'),
                      padding: const EdgeInsets.symmetric(
                        horizontal: LmuSizes.size_16,
                      ),
                      child: LmuContentTile(
                        contentTileType: ContentTileType.bottom,
                        contentList: [
                          LmuListItem.base(
                            title: context.locals.home.tuitionFee,
                            titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                            subtitle: " €",
                            subtitleTextColor: context.colors.brandColors.textColors.strongColors.base,
                            trailingArea: LucideIcon(
                              LucideIcons.copy,
                              size: LmuSizes.size_16,
                              strokeWidth: 2.3,
                              color: context.colors.brandColors.textColors.strongColors.base,
                            ),
                            mainContentAlignment: MainContentAlignment.center,
                            onTap: () {
                              CopyToClipboardUtil.copyToClipboard(
                                  context: context, copiedText: "", message: context.locals.home.tuitionFeeCopy);
                            },
                          ),
                          LmuListItem.base(
                            title: context.locals.home.receiver,
                            titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                            subtitle: "",
                            subtitleTextColor: context.colors.brandColors.textColors.strongColors.base,
                            trailingArea: LucideIcon(
                              LucideIcons.copy,
                              size: LmuSizes.size_16,
                              strokeWidth: 2.3,
                              color: context.colors.brandColors.textColors.strongColors.base,
                            ),
                            mainContentAlignment: MainContentAlignment.center,
                            onTap: () {
                              CopyToClipboardUtil.copyToClipboard(
                                  context: context, copiedText: "", message: context.locals.home.receiverCopy);
                            },
                          ),
                          LmuListItem.base(
                            title: context.locals.home.iban,
                            titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                            subtitle: "",
                            subtitleTextColor: context.colors.brandColors.textColors.strongColors.base,
                            trailingArea: LucideIcon(
                              LucideIcons.copy,
                              size: LmuSizes.size_16,
                              strokeWidth: 2.3,
                              color: context.colors.brandColors.textColors.strongColors.base,
                            ),
                            maximizeTrailingTitleArea: true,
                            onTap: () {
                              CopyToClipboardUtil.copyToClipboard(
                                  context: context, copiedText: "", message: context.locals.home.ibanCopy);
                            },
                            mainContentAlignment: MainContentAlignment.center,
                          ),
                          LmuListItem.base(
                            title: context.locals.home.reference,
                            titleColor: context.colors.neutralColors.textColors.mediumColors.base,
                            subtitle: "",
                            subtitleTextColor: context.colors.brandColors.textColors.strongColors.base,
                            maximizeTrailingTitleArea: true,
                            trailingArea: LucideIcon(
                              LucideIcons.copy,
                              size: LmuSizes.size_16,
                              strokeWidth: 2.3,
                              color: context.colors.brandColors.textColors.strongColors.base,
                            ),
                            onTap: () {
                              CopyToClipboardUtil.copyToClipboard(
                                  context: context, copiedText: "", message: context.locals.home.referenceCopy);
                            },
                            mainContentAlignment: MainContentAlignment.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: LmuSizes.size_12,
                              vertical: LmuSizes.size_12,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                LmuUrlLauncher.launchWebsite(
                                  context: context,
                                  url:
                                      "https://www.lmu.de/de/workspace-fuer-studierende/1x1-des-studiums/rueckmeldung/",
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LmuText.bodyXSmall(
                                    "Offizielle Informationen zur Rückmeldung.",
                                    color: context.colors.neutralColors.textColors.weakColors.base,
                                  ),
                                  const SizedBox(width: LmuSizes.size_4),
                                  LucideIcon(
                                    LucideIcons.externalLink,
                                    size: LmuSizes.size_12,
                                    strokeWidth: 2.3,
                                    color: context.colors.neutralColors.textColors.weakColors.base,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),
          ],
        );
      },
    );
  }
}
