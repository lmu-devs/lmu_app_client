import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../../services/mensa_user_preferences_service.dart';

class MensaOverviewLoadingView extends StatelessWidget {
  const MensaOverviewLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteMensas = GetIt.I.get<MensaUserPreferencesService>().favoriteMensaIdsNotifier.value;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LmuTileHeadline.base(title: context.locals.app.favorites, customBottomPadding: LmuSizes.size_6),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _calculateFavoriteLoadingItemCount(favoriteMensas.length),
              itemBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: LmuSizes.size_6),
                child: LmuCardLoading(
                  hasTag: true,
                  hasSubtitle: true,
                  subtitleLength: 3,
                  hasLargeImage: false,
                  hasFavoriteStar: true,
                  hasFavoriteCount: true,
                  hasDivider: false,
                ),
              ),
            ),
            const SizedBox(height: 26),
            LmuTileHeadline.base(title: context.locals.canteen.allCanteens),
            LmuButtonRow(
              hasHorizontalPadding: false,
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
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) => const LmuCardLoading(
                hasTag: true,
                hasSubtitle: true,
                subtitleLength: 3,
                hasLargeImage: true,
                hasFavoriteStar: true,
                hasFavoriteCount: true,
                hasDivider: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateFavoriteLoadingItemCount(int favoriteMensasCount) {
    return favoriteMensasCount > 0 ? favoriteMensasCount : 2;
  }
}
