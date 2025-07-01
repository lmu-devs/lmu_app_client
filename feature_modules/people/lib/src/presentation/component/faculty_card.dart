import 'package:core/components.dart';
import 'package:flutter/material.dart';

class FacultyCard extends StatelessWidget {
  const FacultyCard({
    super.key,
    required this.title,
    required this.onTap,
    this.emoji = "📚",
  });

  final String title;
  final void Function() onTap;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return LmuContentTile(
      content: LmuListItem.action(
        title: title,
        onTap: onTap,
        actionType: LmuListItemAction.chevron,
        leadingArea: const LmuInListBlurEmoji(emoji: "📚"),
      ),
    );
  }
}
