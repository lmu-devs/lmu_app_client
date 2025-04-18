import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

enum EmojiFeedback {
  bad,
  neutral,
  good,
}

class EmojiFeedbackSelector extends StatelessWidget {
  final ValueNotifier<String?> feedbackNotifier;
  final Function(String) onFeedbackSelected;

  const EmojiFeedbackSelector({
    required this.feedbackNotifier,
    required this.onFeedbackSelected,
    super.key,
  });

  static const feedbackOptions = [
    {'emoji': '😕️', 'value': EmojiFeedback.bad},
    {'emoji': '😄', 'value': EmojiFeedback.neutral},
    {'emoji': '🥳', 'value': EmojiFeedback.good},
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: feedbackNotifier,
      builder: (context, currentFeedback, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: feedbackOptions.map((option) {
            final EmojiFeedback feedbackValue = option['value'] as EmojiFeedback;
            final String apiValue = feedbackValue.toString().split('.').last.toUpperCase();
            final isSelected = currentFeedback == apiValue;
            return GestureDetector(
              onTap: () {
                feedbackNotifier.value = apiValue;
                onFeedbackSelected(apiValue);
                LmuVibrations.secondary();
              },
              child: SizedBox(
                width: LmuActionSizes.large + LmuSizes.size_20,
                height: LmuActionSizes.large,
                child: Center(
                  child: Opacity(
                    opacity: isSelected ? 1 : 0.4,
                    child: Text(
                      option['emoji'].toString(),
                      style: const TextStyle(
                        fontSize: 36,
                      ),
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
