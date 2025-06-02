import 'package:core/components.dart';
import 'package:flutter/material.dart';

class PeopleCard extends StatelessWidget {
  const PeopleCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.onTap,
    required this.hasFavoriteStar,
    required this.onFavoriteTap,
  });

  final String id;
  final String title;
  final String description;
  final void Function() onTap;
  final bool hasFavoriteStar;
  final void Function() onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LmuCard(
          title: title,
          subtitle: description,
          leadingIcon: const LmuInListBlurEmoji(emoji: " 👤 "),
          onTap: onTap,
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: Icon(
              hasFavoriteStar ? Icons.star : Icons.star_border,
              color: hasFavoriteStar ? Colors.amber : Colors.grey,
            ),
            onPressed: onFavoriteTap,
          ),
        ),
      ],
    );
  }
}
