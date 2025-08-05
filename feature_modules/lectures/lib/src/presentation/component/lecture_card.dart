import 'package:core/components.dart';
import 'package:flutter/material.dart';

class LectureCard extends StatelessWidget {
  const LectureCard({
    super.key,
    required this.id,
    required this.title,
    required this.tags,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteTap,
  });

  final String id;
  final String title;
  final List<String> tags;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return LmuCard(
      title: title,
      hasFavoriteStar: true,
      isFavorite: isFavorite,
      onFavoriteTap: onFavoriteTap,
      onTap: onTap,
      customSubtitle: tags.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: tags
                    .map((tag) => LmuInTextVisual.text(
                          title: tag,
                          actionType: ActionType.base,
                        ))
                    .toList(),
              ),
            )
          : null,
    );
  }
}
