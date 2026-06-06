import 'package:core/components.dart';
import 'package:flutter/material.dart';

import '../../domain/models/club.dart';

class ClubCard extends StatelessWidget {
  const ClubCard({super.key, required this.club, this.onTap});

  final Club club;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return LmuContentTile(
      content: LmuListItem.action(
        actionType: LmuListItemAction.chevron,
        title: club.title,
        subtitle: club.description,
        mainContentAlignment: MainContentAlignment.top,
        leadingArea: club.image != null ? LmuInListImage(imageUrl: club.image!.url) : null,
        onTap: onTap,
      ),
    );
  }
}
