import 'package:core/components.dart';
import 'package:core_routes/clubs.dart';
import 'package:flutter/material.dart';

import '../../domain/models/club.dart';

class LmuDeveloperClubTile extends StatelessWidget {
  const LmuDeveloperClubTile({super.key, required this.club});

  final Club club;

  @override
  Widget build(BuildContext context) {
    return LmuContentTile(
      content: LmuListItem.action(
        actionType: LmuListItemAction.chevron,
        title: club.title,
        subtitle: club.description,
        leadingArea: club.image != null ? LmuInListImage(imageUrl: club.image!.url) : null,
        onTap: () => ClubDetailRoute(clubId: club.id).go(context),
      ),
    );
  }
}
