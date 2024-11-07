import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../bloc/mensa_favorite_cubit/mensa_favorite_cubit.dart';
import '../extensions/opening_hours_extensions.dart';
import '../repository/api/models/mensa_model.dart';
import '../repository/api/models/mensa_type.dart';
import '../widgets/widgets.dart';

enum SortOption {
  alphabetically,
  distance,
  rating,
  type,
}

class MensaContentView extends StatelessWidget {
  MensaContentView({
    Key? key,
    required this.mensaModels,
  })  : sortOptionNotifier = ValueNotifier(SortOption.alphabetically),
        sortedMensaModelsNotifier = ValueNotifier(SortOption.alphabetically.sort(mensaModels)),
        super(key: key);

  final List<MensaModel> mensaModels;
  final ValueNotifier<SortOption> sortOptionNotifier;
  final ValueNotifier<List<MensaModel>> sortedMensaModelsNotifier;
  final ValueNotifier<bool> isOpenNowFilerNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final activeSortOption = sortOptionNotifier.value;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(LmuSizes.mediumLarge),
        child: BlocBuilder<MensaFavoriteCubit, MensaFavoriteState>(
          bloc: GetIt.I.get<MensaFavoriteCubit>(),
          builder: (context, state) {
            if (state is! MensaFavoriteLoadSuccess) {
              return const SizedBox.shrink();
            }

            final favoriteMensaIds = state.favoriteMensaIds;

            final favoriteMensaModels = _getFavoriteMensaModels(favoriteMensaIds);
            final localizations = context.localizations;

            return Column(
              children: [
                LmuTileHeadline.base(
                  title: context.localizations.favorites,
                ),
                favoriteMensaModels.isNotEmpty
                    ? _buildFavoriteMensaList(favoriteMensaModels)
                    : MensaOverviewPlaceholderTile(
                        title: localizations.noFavorites,
                        leadingWidget: const StarIcon.active(),
                      ),
                const SizedBox(height: LmuSizes.xxlarge),
                LmuTileHeadline.base(
                  title: localizations.allCanteens,
                  bottomWidget: Row(
                    children: [
                      _buildSortButton(localizations, activeSortOption),
                      const SizedBox(width: LmuSizes.mediumSmall),
                      _buildOpenNowFilterButton(localizations),
                    ],
                  ),
                ),
                _buildAllMensaList(favoriteMensaIds)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFavoriteMensaList(List<MensaModel> favoriteMensaModels) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: favoriteMensaModels.length,
      itemBuilder: (context, index) {
        final mensaModel = favoriteMensaModels[index];

        return MensaOverviewTile(
          mensaModel: mensaModel,
          hasDivider: index == mensaModels.length - 1,
          isFavorite: true,
          hasLargeImage: false,
        );
      },
    );
  }

  Widget _buildSortButton(AppLocalizations localizations, SortOption activeSortOption) {
    return ValueListenableBuilder(
      valueListenable: sortOptionNotifier,
      builder: (context, activeSortOption, _) {
        return LmuButton(
          title: SortOption.values.firstWhere((option) => option == activeSortOption).title(localizations),
          emphasis: ButtonEmphasis.secondary,
          trailingIcon: LucideIcons.chevron_down,
          onTap: () => _showSortOptionActionSheet(context, activeSortOption),
        );
      },
    );
  }

  Widget _buildOpenNowFilterButton(AppLocalizations localizations) {
    return ValueListenableBuilder(
      valueListenable: isOpenNowFilerNotifier,
      builder: (context, isOpenNowFilterActive, _) {
        return LmuButton(
          title: localizations.openNow,
          emphasis: isOpenNowFilterActive ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
          onTap: () => isOpenNowFilerNotifier.value = !isOpenNowFilerNotifier.value,
        );
      },
    );
  }

  Widget _buildAllMensaList(List<String> favoriteMensaIds) {
    return ValueListenableBuilder(
      valueListenable: sortedMensaModelsNotifier,
      builder: (context, sortedMensaModels, _) {
        return ValueListenableBuilder(
          valueListenable: isOpenNowFilerNotifier,
          builder: (context, isFilterActive, _) {
            final filteredMensaModels = sortedMensaModels.where((element) {
              if (!isFilterActive) {
                return true;
              }
              return element.openingHours.mensaStatus != MensaStatus.closed;
            }).toList();

            if (filteredMensaModels.isEmpty) {
              return MensaOverviewPlaceholderTile(
                title: context.localizations.allClosed,
                icon: LucideIcons.bone,
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredMensaModels.length,
              itemBuilder: (context, index) {
                final isFavorite = favoriteMensaIds.contains(filteredMensaModels[index].canteenId);
                return Padding(
                  padding: const EdgeInsets.only(bottom: LmuSizes.xsmall),
                  child: MensaOverviewTile(
                    mensaModel: filteredMensaModels[index],
                    isFavorite: isFavorite,
                    hasDivider: index == mensaModels.length - 1,
                    hasLargeImage: filteredMensaModels[index].images.isNotEmpty,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _showSortOptionActionSheet(BuildContext context, SortOption activeSortOption) {
    LmuBottomSheet.show(
      context,
      content: ValueListenableBuilder(
        valueListenable: sortOptionNotifier,
        builder: (context, activeValue, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...SortOption.values.map(
                (sortOption) {
                  final isActive = sortOption == activeValue;

                  final textColor = activeSortOption.textColor(
                    context.colors,
                    isActive: isActive,
                  );

                  return Column(
                    children: [
                      LmuListItem.base(
                        title: sortOption.title(context.localizations),
                        titleColor: textColor,
                        mainContentAlignment: MainContentAlignment.center,
                        leadingArea: LmuIcon(
                          icon: sortOption.icon,
                          size: LmuIconSizes.medium,
                          color: textColor,
                        ),
                        onTap: () async {
                          sortOptionNotifier.value = sortOption;
                          sortedMensaModelsNotifier.value = sortOption.sort(mensaModels);

                          Future.delayed(
                            const Duration(milliseconds: 100),
                            () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          );
                        },
                      ),
                      if (sortOption != SortOption.values.last)
                        const SizedBox(
                          height: LmuSizes.mediumSmall,
                        ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  List<MensaModel> _getFavoriteMensaModels(List<String> favoriteMensaIds) {
    return favoriteMensaIds.map((id) => mensaModels.firstWhere((mensa) => mensa.canteenId == id)).toList();
  }
}

extension SortOptionExtension on SortOption {
  List<MensaModel> sort(
    List<MensaModel> mensaModels,
  ) {
    switch (this) {
      case SortOption.alphabetically:
        return List.from(mensaModels)..sort((a, b) => a.name.compareTo(b.name));
      case SortOption.rating:
        return List.from(mensaModels)..sort((a, b) => a.ratingModel.likeCount.compareTo(b.ratingModel.likeCount));
      case SortOption.type:
        return List.from(mensaModels)
          ..sort((a, b) {
            final typeComparison = a.type.index.compareTo(b.type.index);
            if (typeComparison != 0) return typeComparison;
            return a.name.compareTo(b.name);
          });
      default:
        return List.from(mensaModels);
    }
  }

  IconData get icon {
    switch (this) {
      case SortOption.alphabetically:
        return LucideIcons.arrow_down_a_z;
      case SortOption.distance:
        return LucideIcons.arrow_down_0_1;
      case SortOption.rating:
        return LucideIcons.arrow_down_1_0;
      case SortOption.type:
        return LucideIcons.arrow_down_1_0;
    }
  }

  String title(AppLocalizations localizations) {
    switch (this) {
      case SortOption.alphabetically:
        return localizations.alphabetically;
      case SortOption.distance:
        return localizations.distance;
      case SortOption.rating:
        return localizations.rating;
      case SortOption.type:
        return localizations.type;
    }
  }

  Color textColor(
    LmuColors colors, {
    required bool isActive,
  }) {
    if (isActive) {
      return colors.brandColors.textColors.strongColors.base;
    }
    return colors.neutralColors.textColors.mediumColors.base;
  }
}

extension TypeExtension on MensaType {
  int compareTo(MensaType other) => index.compareTo(other.index);
}
