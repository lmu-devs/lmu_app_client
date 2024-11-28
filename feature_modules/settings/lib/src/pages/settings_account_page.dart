import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class SettingsAccountPage extends StatelessWidget {
  const SettingsAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.locals.settings;

    return LmuScaffoldWithAppBar(
      largeTitle: localization.account,
      leadingAction: LeadingAction.back,
      body: Padding(
        padding: const EdgeInsets.all(LmuSizes.mediumLarge),
        child: Column(
          children: [
            LmuContentTile(
              content: [
                LmuListItem.base(
                  subtitle: localization.accountStatus,
                  trailingTitle: localization.accountStatusLocal,
                ),
                LmuListItem.base(
                  subtitle: localization.accountMemberSince,
                  trailingTitle: "5 days",
                ),
              ],
            ),
            const SizedBox(
              height: LmuSizes.mediumSmall,
            ),
            LmuButton(
              title: localization.connectToAccount,
              size: ButtonSize.large,
              emphasis: ButtonEmphasis.secondary,
              state: ButtonState.disabled,
              showFullWidth: true,
              onTap: () {
                print("connect to dominik avatar style");
              },
            ),
            const SizedBox(
              height: LmuSizes.mediumLarge,
            ),
            LmuText.bodyXSmall(
              localization.connectToAccountDescription,
              color: context.colors.neutralColors.textColors.weakColors.base,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: LmuSizes.xxlarge,
            ),
            LmuTileHeadline.base(
              title: localization.manageData,
            ),
            LmuButton(
              title: localization.deleteDataButton,
              size: ButtonSize.large,
              emphasis: ButtonEmphasis.secondary,
              showFullWidth: true,
              onTap: () {
                LmuBottomSheet.show(
                  context,
                  content: _buildDeleteDataBottomSheet(context, localization),
                );
              },
            ),
            const SizedBox(
              height: LmuSizes.mediumLarge,
            ),
            LmuText.bodyXSmall(
              localization.deleteDataDescription,
              color: context.colors.neutralColors.textColors.weakColors.base,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: LmuSizes.xxlarge,
            ),
            LmuTileHeadline.base(
              title: localization.technicalDetails,
            ),
            LmuContentTile(
              content: [
                LmuListItem.base(
                  subtitle: localization.deviceId,
                  trailingTitle: "1234567890",
                  onTap: () {
                    print("copy device id");
                  },
                ),
              ],
            ),
            const SizedBox(
              height: LmuSizes.xhuge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteDataBottomSheet(BuildContext context, SettingsLocalizations localization) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: LmuSizes.mediumLarge),
        LmuText.h3(
          localization.deleteDataTitleFinal,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: LmuSizes.large),
        LmuText.body(
          localization.deleteDataDescriptionFinal,
          color: context.colors.neutralColors.textColors.mediumColors.base,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: LmuSizes.xxlarge),
        LmuButton(
          title: localization.deleteDataButtonFinal,
          size: ButtonSize.large,
          emphasis: ButtonEmphasis.primary,
          action: ButtonAction.destructive,
          showFullWidth: true,
          onTap: () {
            print("delete data");
          },
        ),
      ],
    );
  }
}
