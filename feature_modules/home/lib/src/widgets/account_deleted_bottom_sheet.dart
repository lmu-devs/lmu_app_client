import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class AccountDeletedBottomSheet extends StatelessWidget {
  const AccountDeletedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        children: [
          const SizedBox(height: LmuSizes.size_64),
          Icon(
            LucideIcons.user_x,
            color: context.colors.brandColors.textColors.strongColors.base,
            size: LmuIconSizes.xlarge,
          ),
          const SizedBox(height: LmuSizes.size_16),
          LmuText.h1(context.locals.settings.accountDeletedTitle),
          const SizedBox(height: LmuSizes.size_16),
          LmuText.body(
            context.locals.settings.accountDeletedText,
            color: context.colors.neutralColors.textColors.mediumColors.base,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          LmuButton(
            title: context.locals.settings.accountDeletedButton,
            size: ButtonSize.large,
            showFullWidth: true,
            onTap: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
          const SizedBox(height: LmuSizes.size_48),
        ],
      ),
    );
  }
}
