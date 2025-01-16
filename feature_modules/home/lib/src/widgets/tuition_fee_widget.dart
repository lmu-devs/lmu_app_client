import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_svg/lucide_icons_svg.dart';

import '../repository/api/models/home_model.dart';

class TuitionFeeWidget extends StatelessWidget {
  TuitionFeeWidget({
    super.key,
    required this.homeData,
  }) : _tuitionPayed = ValueNotifier<bool>(false);

  final HomeModel homeData;
  final ValueNotifier<bool> _tuitionPayed;

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

  String _getSemester(DateTime date, HomeLocalizations locals) {
    return date.month >= 8 ? locals.winter : locals.summer;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _tuitionPayed,
      builder: (context, isPayed, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: LmuSizes.size_16,
                right: LmuSizes.size_16,
                top: LmuSizes.size_24,
              ),
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
                        content: [
                          LmuListItem.base(
                            title: context.locals.home.tuitionFeePayed(
                              _getSemester(DateTime.now(), context.locals.home),
                              DateTime.now().year,
                            ),
                            titleColor: context.colors.successColors.textColors.strongColors.base,
                            trailingArea: LmuCheckboxAction(
                              isActive: isPayed,
                            ),
                            mainContentAlignment: MainContentAlignment.center,
                            onTap: () {
                              _tuitionPayed.value = !_tuitionPayed.value;
                            },
                          ),
                        ],
                      )
                    : LmuContentTile.top(
                        key: const ValueKey('not_payed'),
                        content: [
                          LmuListItem.base(
                            title: context.locals.home.tuitionFeeCountdown(
                              CountdownUtils.getRemainingTime(
                                context.locals.app,
                                DateTime.now(),
                                homeData.semesterFee.timePeriod.endDate,
                              ),
                            ),
                            trailingArea: LmuCheckboxAction(
                              isActive: isPayed,
                            ),
                            mainContentAlignment: MainContentAlignment.center,
                            onTap: () {
                              _tuitionPayed.value = !_tuitionPayed.value;
                            },
                          ),
                        ],
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
                      key: const ValueKey('bottom_content'),
                      padding: const EdgeInsets.symmetric(
                        horizontal: LmuSizes.size_16,
                      ),
                      child: LmuContentTile.bottom(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        content: [
                          LmuListItem.base(
                            subtitle: context.locals.home.tuitionFee,
                            trailingTitle: "${homeData.semesterFee.fee.toStringAsFixed(2)} €",
                            trailingTitleColor: context.colors.brandColors.textColors.strongColors.base,
                            trailingArea: LucideIcon(
                              LucideIcons.copy,
                              size: LmuSizes.size_16,
                              strokeWidth: 2.3,
                              color: context.colors.brandColors.textColors.strongColors.base,
                            ),
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
                            trailingTitleColor: context.colors.brandColors.textColors.strongColors.base,
                            trailingArea: LucideIcon(
                              LucideIcons.copy,
                              size: LmuSizes.size_16,
                              strokeWidth: 2.3,
                              color: context.colors.brandColors.textColors.strongColors.base,
                            ),
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
                            trailingTitleColor: context.colors.brandColors.textColors.strongColors.base,
                            trailingArea: LucideIcon(
                              LucideIcons.copy,
                              size: LmuSizes.size_16,
                              strokeWidth: 2.3,
                              color: context.colors.brandColors.textColors.strongColors.base,
                            ),
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
                            trailingTitleColor: context.colors.brandColors.textColors.strongColors.base,
                            maximizeTrailingTitleArea: true,
                            trailingArea: LucideIcon(
                              LucideIcons.copy,
                              size: LmuSizes.size_16,
                              strokeWidth: 2.3,
                              color: context.colors.brandColors.textColors.strongColors.base,
                            ),
                            onTap: () {
                              _copyToClipboard(
                                  context: context,
                                  copiedText: homeData.semesterFee.reference,
                                  message: context.locals.home.referenceCopy);
                            },
                            mainContentAlignment: MainContentAlignment.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: LmuSizes.size_12,
                              vertical: LmuSizes.size_12,
                            ),
                            child: LmuText.bodyXSmall(
                              "Offizielle Informationen zur Rückmeldung.",
                              color: context.colors.neutralColors.textColors.weakColors.base,
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
