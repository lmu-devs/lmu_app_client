import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../cubit/cubit.dart';
import '../services/libraries_user_preference_service.dart';

class LibrariesLoadingView extends StatelessWidget {
  const LibrariesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final librariesCubit = GetIt.I.get<LibrariesCubit>();
    final favoriteLibraries = GetIt.I.get<LibrariesUserPreferenceService>().favoriteLibraryIdsNotifier.value;

    return BlocListener<LibrariesCubit, LibrariesState>(
      bloc: GetIt.I.get<LibrariesCubit>(),
      listenWhen: (_, current) => current is LibrariesLoadFailure,
      listener: (context, state) {
        if (state is LibrariesLoadFailure) {
          final localizations = context.locals.canteen;
          const duration = Duration(seconds: 10);

          LmuToast.show(
            context: context,
            message: localizations.noConnection,
            actionText: localizations.retry,
            type: ToastType.error,
            duration: duration,
            onActionPressed: () => librariesCubit.loadLibraries(),
          );

          Future.delayed(duration, () {
            librariesCubit.loadLibraries();
          });
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
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
              const SizedBox(height: 26),
              LmuTileHeadline.base(title: context.locals.libraries.allLibraries),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    LmuMapImageButton(onTap: () {}),
                    const SizedBox(width: LmuSizes.size_8),
                    LmuIconButton(
                      icon: LucideIcons.search,
                      isDisabled: true,
                      onPressed: () {},
                    ),
                    const SizedBox(width: LmuSizes.size_8),
                    LmuButton(
                      title: context.locals.canteen.alphabetically,
                      emphasis: ButtonEmphasis.secondary,
                      state: ButtonState.disabled,
                      trailingIcon: LucideIcons.chevron_down,
                    ),
                    const SizedBox(width: LmuSizes.size_8),
                    LmuButton(
                      title: context.locals.canteen.openNow,
                      emphasis: ButtonEmphasis.secondary,
                      state: ButtonState.disabled,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: LmuSizes.size_16),
              ListView.builder(
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
            ],
          ),
        ),
      ),
    );
  }

  int _calculateFavoriteLoadingItemCount(int favoriteMensasCount) {
    return favoriteMensasCount > 0 ? favoriteMensasCount : 2;
  }
}
