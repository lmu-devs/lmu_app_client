import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/taste_profile/taste_profile_cubit.dart';
import '../../bloc/taste_profile/taste_profile_state.dart';
import '../../widgets/taste_profile/taste_profile_footer_section.dart';
import '../../widgets/taste_profile/taste_profile_title_section.dart';

class TasteProfileLoadingView extends StatelessWidget {
  const TasteProfileLoadingView({super.key});

  static const _preferencePresetsItems = 4;
  static const _allergiesPresetsItems = 2;
  static const _labelsItems = [4, 2, 3, 5];
  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.canteen;
    final tasteProfileCubit = GetIt.I.get<TasteProfileCubit>();

    return BlocListener<TasteProfileCubit, TasteProfileState>(
      bloc: tasteProfileCubit,
      listener: (context, state) {
        if (state is TasteProfileLoadFailure) {
          final localizations = context.locals.canteen;

          LmuToast.show(
            context: context,
            message: localizations.noConnection,
            actionText: localizations.retry,
            type: ToastType.error,
            onActionPressed: () => tasteProfileCubit.loadTasteProfile(),
            duration: const Duration(minutes: 66),
          );
        }
      },
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: TasteProfileTitleSection()),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                children: [
                  LmuContentTile(
                    content: [
                      LmuListItemLoading(
                        titleLength: 2,
                        action: LmuListItemAction.toggle,
                      ),
                    ],
                  ),
                  SizedBox(height: LmuSizes.size_32),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                children: [
                  LmuTileHeadline.base(title: localizations.presets),
                  LmuContentTile(
                    content: [
                      for (var i = 0; i < _preferencePresetsItems; i++)
                        LmuListItemLoading(
                          titleLength: 2,
                          leadingArea: LmuText.body('🍔'),
                          action: LmuListItemAction.radio,
                        ),
                    ],
                  ),
                  const SizedBox(height: LmuSizes.size_16),
                  LmuContentTile(
                    content: [
                      for (var i = 0; i < _allergiesPresetsItems; i++)
                        LmuListItemLoading(
                          titleLength: 2,
                          leadingArea: LmuText.body('🍔'),
                          action: LmuListItemAction.checkbox,
                        ),
                    ],
                  ),
                  const SizedBox(height: LmuSizes.size_32),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: LmuTileHeadline.base(title: localizations.tastePreferences),
            ),
          ),
          SliverStickyHeader(
            header: const LmuTabBarLoading(
              hasDivider: true,
            ),
            sliver: SliverPadding(
              padding: const EdgeInsets.only(left: LmuSizes.size_16, right: LmuSizes.size_16, top: LmuSizes.size_16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    for (var i = 0; i < _labelsItems.length; i++)
                      Column(
                        children: [
                          LmuContentTile(
                            content: [
                              for (var j = 0; j < _labelsItems[i]; j++)
                                LmuListItemLoading(
                                  titleLength: 2,
                                  leadingArea: LmuText.body('🍔'),
                                  action: LmuListItemAction.checkbox,
                                ),
                            ],
                          ),
                          const SizedBox(height: LmuSizes.size_16),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: TasteProfileFooterSection()),
        ],
      ),
    );
  }
}
