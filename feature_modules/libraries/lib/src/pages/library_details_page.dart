import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/extensions.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/api.dart';
import '../services/libraries_user_preference_service.dart';

class LibraryDetailsPage extends StatelessWidget {
  const LibraryDetailsPage({
    super.key,
    required this.library,
    this.withAppBar = true,
  });

  final LibraryModel library;
  final bool withAppBar;

  @override
  Widget build(BuildContext context) {
    final content = Container();

    if (!withAppBar) return content;

    return LmuMasterAppBar(
      largeTitle: library.name,
      leadingAction: LeadingAction.back,
      trailingWidgets: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_4),
          child: ValueListenableBuilder(
            valueListenable: GetIt.I<LibrariesUserPreferenceService>().favoriteLibraryIdsNotifier,
            builder: (context, favoriteLibraryIds, _) {
              final isFavorite = favoriteLibraryIds.contains(library.id);
              final calculatedLikes = library.rating.calculateLikeCount(isFavorite);
              return LmuFavoriteButton(
                isFavorite: isFavorite,
                calculatedLikes: calculatedLikes,
                onTap: () => GetIt.I<LibrariesUserPreferenceService>().toggleFavoriteLibraryId(library.id),
              );
            },
          ),
        ),
      ],
      imageUrls: library.images.isNotEmpty ? library.images.map((image) => image.url).toList() : [],
      largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
      largeTitleTrailingWidget: LmuInTextVisual.text(
        title: context.locals.libraries.library,
        size: InTextVisualSize.large,
        textColor: context.colors.customColors.textColors.library,
        backgroundColor: context.colors.customColors.backgroundColors.library,
      ),
      body: SingleChildScrollView(
        child: content,
      ),
    );
  }
}
