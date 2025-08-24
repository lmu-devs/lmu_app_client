import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../services/libraries_user_preference_service.dart';

class LibrariesLoadingView extends StatelessWidget {
  const LibrariesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteLibraries = GetIt.I.get<LibrariesUserPreferenceService>().favoriteLibraryIdsNotifier.value;

    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: LmuSizes.size_16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                children: [
                  LmuTileHeadline.base(title: context.locals.app.favorites, customBottomPadding: LmuSizes.size_6),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _calculateFavoriteLoadingItemCount(favoriteLibraries.length),
                    itemBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: LmuSizes.size_6),
                      child: LmuCardLoading(
                        hasSubtitle: true,
                        subtitleLength: 3,
                        hasLargeImage: false,
                        hasFavoriteStar: true,
                        hasFavoriteCount: true,
                        hasDivider: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: LmuTileHeadline.base(title: context.locals.libraries.allLibraries),
            ),
            LmuButtonRow(
              buttons: [
                LmuMapImageButton(onTap: () {}),
                LmuIconButton(
                  icon: LucideIcons.search,
                  isDisabled: true,
                  onPressed: () {},
                ),
                LmuButton(
                  title: context.locals.canteen.alphabetically,
                  emphasis: ButtonEmphasis.secondary,
                  state: ButtonState.disabled,
                  trailingIcon: LucideIcons.chevron_down,
                ),
                LmuButton(
                  title: context.locals.canteen.openNow,
                  emphasis: ButtonEmphasis.secondary,
                  state: ButtonState.disabled,
                ),
              ],
            ),
            const SizedBox(height: LmuSizes.size_16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) => const LmuCardLoading(
                  hasSubtitle: true,
                  subtitleLength: 3,
                  hasLargeImage: true,
                  hasFavoriteStar: true,
                  hasFavoriteCount: true,
                  hasDivider: true,
                ),
              ),
            ),
            const SizedBox(height: LmuSizes.size_96)
          ],
        ),
    );
  }

  int _calculateFavoriteLoadingItemCount(int favoriteMensasCount) {
    return favoriteMensasCount > 0 ? favoriteMensasCount : 2;
  }
}
