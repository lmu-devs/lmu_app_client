import 'package:core/constants.dart';
import 'package:flutter/material.dart';

class EmojiFeedbackSelector extends StatelessWidget {
  final String? selectedFeedback;
  final Function(String) onFeedbackSelected;
  final _selectedFeedbackNotifier = ValueNotifier<String?>(null);

  EmojiFeedbackSelector({
    super.key,
    required this.onFeedbackSelected,
    this.selectedFeedback,
  }) {
    _selectedFeedbackNotifier.value = selectedFeedback;
  }

  static const feedbackOptions = [
    {'emoji': '😕️', 'value': 'Bad'},
    {'emoji': '😄', 'value': 'Neutral'},
    {'emoji': '🥳', 'value': 'Great'},
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _selectedFeedbackNotifier,
      builder: (context, currentFeedback, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: feedbackOptions.map((option) {
            final isSelected = currentFeedback == null || currentFeedback == option['value'];
            return GestureDetector(
              onTap: () {
                _selectedFeedbackNotifier.value = option['value'];
                onFeedbackSelected(option['value']!);
              },
              child: SizedBox(
                width: LmuActionSizes.large + LmuSizes.large,
                height: LmuActionSizes.large,
                child: Center(
                  child: Opacity(
                    opacity: isSelected ? 1 : 0.4,
                    child: Text(
                      option['emoji']!,
                      style: const TextStyle(
                        fontSize: 36,
                      ),
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
