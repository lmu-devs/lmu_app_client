import 'package:core/constants.dart';

import 'package:core/themes.dart';
import 'package:flutter/material.dart';



class EmojiFeedbackSelector extends StatelessWidget {
  final String? selectedFeedback;
  final Function(String) onFeedbackSelected;

  const EmojiFeedbackSelector({
    super.key,
    required this.onFeedbackSelected,
    this.selectedFeedback,
  });

  static const feedbackOptions = [
    {'emoji': '😕️', 'value': 'Bad'},
    {'emoji': '😄', 'value': 'Neutral'},
    {'emoji': '🥳', 'value': 'Great'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: feedbackOptions.map((option) {
        final isSelected = selectedFeedback == option['value'];
        return GestureDetector(
          onTap: () => onFeedbackSelected(option['value']!),
          child: Container(
            width: LmuActionSizes.large + LmuSizes.medium,
            height: LmuActionSizes.large,
            decoration: BoxDecoration(
              border: isSelected ? Border.all(
                color: context.colors.neutralColors.textColors.mediumColors.base,
                width: 2,
              ) : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                option['emoji']!,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}