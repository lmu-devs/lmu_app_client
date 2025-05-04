import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../../domain/models/emoji_feedback.dart';

class FeedbackEmojiSelector extends StatefulWidget {
  const FeedbackEmojiSelector({super.key, required this.onFeedbackSelected});

  final Function(EmojiFeedback) onFeedbackSelected;

  @override
  State<FeedbackEmojiSelector> createState() => _FeedbackEmojiSelectorState();
}

class _FeedbackEmojiSelectorState extends State<FeedbackEmojiSelector> {
  EmojiFeedback? _selectedFeedback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: EmojiFeedback.values.map((option) {
          final isSelected = _selectedFeedback == option;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedFeedback = option);
              widget.onFeedbackSelected(option);
              LmuVibrations.secondary();
            },
            child: SizedBox(
              width: LmuActionSizes.large + LmuSizes.size_20,
              height: LmuActionSizes.large,
              child: Center(
                child: Opacity(
                  opacity: isSelected ? 1 : 0.4,
                  child: Text(
                    option.emoji,
                    style: const TextStyle(fontSize: 36),
                    textScaler: TextScaler.noScaling,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

extension _EmojiFeedbackEmojiExtension on EmojiFeedback {
  String get emoji {
    return switch (this) {
      EmojiFeedback.bad => '😕️',
      EmojiFeedback.neutral => '😄',
      EmojiFeedback.good => '🥳',
    };
  }
}
