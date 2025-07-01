import 'package:core/components.dart';
import 'package:flutter/material.dart';

class FacultyCard extends StatelessWidget {
  final String id;
  final String name;
  final int count;
  final VoidCallback? onTap;

  const FacultyCard({
    required this.id,
    required this.name,
    required this.count,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LmuListItem.action(
      actionType: LmuListItemAction.chevron,
      title: name,
      leadingArea: LmuInListBlurEmoji(emoji: id),
      trailingTitle: count.toString(),
      hasDivider: false,
      onTap: onTap,
    );
  }
}
