import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class BugModal extends StatelessWidget {
  const BugModal({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.feedback;
    return LmuMasterAppBar(
      largeTitle: localizations.bugTitle,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(LmuSizes.mediumLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: LmuSizes.small),
                  LmuText.body(
                    localizations.bugDescription,
                    color: context.colors.neutralColors.textColors.mediumColors.base,
                  ),
                  const SizedBox(height: LmuSizes.xxlarge),
                  LmuInputField(
                    hintText: localizations.bugInputHint,
                    controller: TextEditingController(),
                    isAutofocus: true,
                    isMultiline: true,
                    isAutocorrect: true,
                  ),
                  const SizedBox(height: 400),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(LmuSizes.medium),
                child: LmuButton(
                  title: localizations.bugButton,
                  size: ButtonSize.large,
                  showFullWidth: true,
                  onTap: () {
                    // TODO: send data to backend
                    Navigator.pop(context);
                    LmuToast.show(
                      context: context,
                      message: localizations.bugSuccess,
                      type: ToastType.success,
                    );
                    LmuVibrations.success();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
