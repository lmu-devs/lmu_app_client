import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:intl/intl.dart';

import '../repository/api/models/home_model.dart';
import 'home_links_view.dart';

class HomeOverviewView extends StatelessWidget {
  const HomeOverviewView({
    super.key,
    required this.homeData,
  });

  final HomeModel homeData;

  void _copyToClipboard({
    required BuildContext context,
    required String copiedText,
    required String message,
  }) {
    Clipboard.setData(ClipboardData(text: copiedText));
    LmuToast.show(
      context: context,
      message: message,
      type: ToastType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: LmuSizes.size_24),
        HomeLinksView(links: homeData.links),
        Padding(
          padding: const EdgeInsets.only(
            left: LmuSizes.size_16,
            right: LmuSizes.size_16,
            top: LmuSizes.size_24,
          ),
          child: LmuContentTile.top(
            content: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: LmuSizes.size_12,
                  vertical: LmuSizes.size_12,
                ),
                child: LmuText.body(
                  context.locals.home.lectureFreePeriodDays(
                    homeData.semesterFee.timePeriod.endDate
                        .difference(DateTime.now())
                        .inDays
                        .toString(),
                  ),
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: LmuSizes.size_16,
          ),
          child: LmuContentTile.bottom(
            content: [
              LmuListItem.base(
                subtitle: context.locals.home.tuitionFee,
                trailingTitle:
                    "${homeData.semesterFee.fee.toStringAsFixed(2)} €",
                trailingTitleColor:
                    context.colors.brandColors.textColors.strongColors.base,
                trailingArea: LmuIcon(
                    icon: LucideIcons.copy,
                    size: LmuSizes.size_16,
                    color: context
                        .colors.brandColors.textColors.strongColors.base),
                mainContentAlignment: MainContentAlignment.center,
                onTap: () {
                  _copyToClipboard(
                      context: context,
                      copiedText: homeData.semesterFee.fee.toStringAsFixed(2),
                      message: context.locals.home.tuitionFeeCopy);
                },
              ),
              LmuListItem.base(
                subtitle: context.locals.home.receiver,
                trailingTitle: homeData.semesterFee.receiver,
                trailingTitleColor:
                    context.colors.brandColors.textColors.strongColors.base,
                trailingArea: LmuIcon(
                    icon: LucideIcons.copy,
                    size: LmuSizes.size_16,
                    color: context
                        .colors.brandColors.textColors.strongColors.base),
                mainContentAlignment: MainContentAlignment.center,
                onTap: () {
                  _copyToClipboard(
                      context: context,
                      copiedText: homeData.semesterFee.receiver,
                      message: context.locals.home.receiverCopy);
                },
              ),
              LmuListItem.base(
                subtitle: context.locals.home.iban,
                trailingTitle: homeData.semesterFee.iban,
                trailingTitleColor:
                    context.colors.brandColors.textColors.strongColors.base,
                trailingArea: LmuIcon(
                    icon: LucideIcons.copy,
                    size: LmuSizes.size_16,
                    color: context
                        .colors.brandColors.textColors.strongColors.base),
                maximizeTrailingTitleArea: true,
                onTap: () {
                  _copyToClipboard(
                      context: context,
                      copiedText: homeData.semesterFee.iban,
                      message: context.locals.home.ibanCopy);
                },
                mainContentAlignment: MainContentAlignment.center,
              ),
              LmuListItem.base(
                subtitle: context.locals.home.reference,
                trailingTitle: homeData.semesterFee.reference,
                trailingTitleColor:
                    context.colors.brandColors.textColors.strongColors.base,
                maximizeTrailingTitleArea: true,
                trailingArea: LmuIcon(
                    icon: LucideIcons.copy,
                    size: LmuSizes.size_16,
                    color: context
                        .colors.brandColors.textColors.strongColors.base),
                onTap: () {
                  _copyToClipboard(
                      context: context,
                      copiedText: homeData.semesterFee.reference,
                      message: context.locals.home.referenceCopy);
                },
                mainContentAlignment: MainContentAlignment.center,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: LmuSizes.size_16, vertical: LmuSizes.size_16),
          child: LmuContentTile(
            content: [
              LmuListItem.base(
                subtitle: context.locals.home.lecturePeriod,
                trailingTitle: DateFormat("dd.MM.yyyy")
                    .format(homeData.lectureTime.startDate),
                mainContentAlignment: MainContentAlignment.center,
              ),
              LmuListItem.base(
                subtitle: context.locals.home.lectureFreePeriod,
                trailingTitle: DateFormat("dd.MM.yyyy")
                    .format(homeData.lectureFreeTime.startDate),
                mainContentAlignment: MainContentAlignment.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: LmuSizes.size_96),
      ]),
    );
  }
}
