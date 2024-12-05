import 'package:flutter/material.dart';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/localizations.dart';

class SuggestionModal extends StatelessWidget {
  const SuggestionModal({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.feedback;
    return LmuScaffoldWithAppBar(
      largeTitle: localizations.suggestionTitle,
      stretch: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(LmuSizes.size_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: LmuSizes.size_4),
                  LmuText.body(
                    localizations.suggestionDescription,
                    color: context.colors.neutralColors.textColors.mediumColors.base,
                  ),
                  const SizedBox(height: LmuSizes.size_32),
                  LmuInputField(
                    hintText: localizations.suggestionInputHint,
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
                padding: const EdgeInsets.all(LmuSizes.size_12),
                child: LmuButton(
                  title: localizations.suggestionButton,
                  size: ButtonSize.large,
                  showFullWidth: true,
                  onTap: () {
                    // TODO: send data to backend
                    Navigator.pop(context);
                    LmuToast.show(
                      context: context,
                      message: localizations.suggestionSuccess,
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
