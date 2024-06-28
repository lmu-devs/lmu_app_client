import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/routes.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';
import '../repository/api/api.dart';
import '../utils/utils.dart';
import 'mensa_overview_tile.dart';

class MensaOverview extends StatefulWidget {
  const MensaOverview({
    Key? key,
    required this.mensaCurrentDayCubit,
    required this.mensaModels,
  }) : super(key: key);

  final MensaCurrentDayCubit mensaCurrentDayCubit;
  final List<MensaModel> mensaModels;

  @override
  MensaOverviewState createState() => MensaOverviewState();
}

class MensaOverviewState extends State<MensaOverview> {
  late final MensaCurrentDayCubit _mensaCurrentDayCubit;
  late final List<MensaModel> _mensaModels;
  late final List<MensaDay> mensaDays;
  late final PageController pageController;

  int pageAnimationCounter = 0;
  bool hasManuallySwitchedPage = false;

  @override
  void initState() {
    super.initState();
    _mensaCurrentDayCubit = widget.mensaCurrentDayCubit;
    _mensaModels = widget.mensaModels;
    _initializeMensaDays();
    _initializeCurrentMensaDay();
    _initializePageController();
  }

  void _initializeMensaDays() {
    mensaDays = getMensaDays();
  }

  void _initializeCurrentMensaDay() {
    MensaDay today = MensaDay.now();
    if (mensaDays.contains(today)) {
      _mensaCurrentDayCubit.setCurrentMensaDay(newMensaDay: today);
    } else {
      _mensaCurrentDayCubit.setCurrentMensaDay(
          newMensaDay: mensaDays.firstWhere((day) => day.isAfter(today), orElse: () => mensaDays.first));
    }
  }

  void _initializePageController() {
    pageController = PageController(initialPage: mensaDays.indexOf(_mensaCurrentDayCubit.state));
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocListener<MensaCurrentDayCubit, MensaDay>(
        bloc: _mensaCurrentDayCubit,
        listener: _onMensaDayChanged,
        child: PageView.builder(
          controller: pageController,
          itemCount: mensaDays.length,
          onPageChanged: _onPageChanged,
          itemBuilder: (context, index) => _buildPageViewContent(index),
        ),
      ),
    );
  }

  void _onMensaDayChanged(BuildContext context, MensaDay currentMensaDay) {
    final indexOfCurrentMensaDay = mensaDays.indexOf(currentMensaDay);
    if (!hasManuallySwitchedPage) {
      pageAnimationCounter = (indexOfCurrentMensaDay - (pageController.page?.floor() ?? 0)).abs();
      pageController.animateToPage(
        indexOfCurrentMensaDay,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
    hasManuallySwitchedPage = false;
  }

  void _onPageChanged(int newPage) {
    if (pageAnimationCounter > 0) {
      pageAnimationCounter--;
      return;
    }
    _mensaCurrentDayCubit.setCurrentMensaDay(newMensaDay: mensaDays[newPage]);
    hasManuallySwitchedPage = true;
  }

  Widget _buildPageViewContent(int index) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(LmuSizes.mediumLarge),
        child: BlocBuilder<MensaFavoriteCubit, MensaFavoriteState>(
          builder: (context, state) {
            if (state is MensaFavoriteLoadSuccess) {
              final favoriteMensaModels = _getFavoriteMensaModels(state.favoriteMensaIds);
              final unFavoritedMensaModels = _getUnfavoritedMensaModels(state.favoriteMensaIds);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (favoriteMensaModels.isNotEmpty)
                    _buildMensaOverview(
                      title: "Favorites",
                      mensaModels: favoriteMensaModels,
                      isFavorite: true,
                    ),
                  if (unFavoritedMensaModels.isNotEmpty)
                    _buildMensaOverview(
                      title: "All Mensas",
                      mensaModels: unFavoritedMensaModels,
                      areFavoritesEmpty: favoriteMensaModels.isEmpty,
                    ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  List<MensaModel> _getFavoriteMensaModels(List<String> favoriteMensaIds) {
    return _mensaModels.where((mensa) => favoriteMensaIds.contains(mensa.canteenId)).toList();
  }

  List<MensaModel> _getUnfavoritedMensaModels(List<String> favoriteMensaIds) {
    return _mensaModels.where((mensa) => !favoriteMensaIds.contains(mensa.canteenId)).toList();
  }

  Widget _buildMensaOverview({
    required String title,
    required List<MensaModel> mensaModels,
    bool isFavorite = false,
    bool areFavoritesEmpty = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: areFavoritesEmpty || isFavorite ? LmuSizes.none : LmuSizes.mediumLarge,
            bottom: LmuSizes.mediumLarge,
          ),
          child: LmuText.body(
            title,
            weight: FontWeight.w600,
            color: context.colors.neutralColors.textColors.mediumColors.base,
          ),
        ),
        _MensaOverviewItem(
          mensaModels: mensaModels,
          isFavorite: isFavorite,
        ),
      ],
    );
  }
}

class _MensaOverviewItem extends StatelessWidget {
  const _MensaOverviewItem({
    required this.mensaModels,
    this.isFavorite = false,
  });

  final List<MensaModel> mensaModels;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: mensaModels.length,
          itemBuilder: (context, index) {
            final mensaModel = mensaModels[index];
            final name = mensaModel.name;
            final id = mensaModel.canteenId;
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == mensaModels.length - 1 ? LmuSizes.none : LmuSizes.mediumSmall,
              ),
              child: MensaOverviewTile(
                title: _getMensaNameWithoutType(
                  name,
                ),
                type: mapStringToMensaType(
                  name,
                ),
                status: getMensaStatus(
                  mensaModel.openingHours,
                ),
                isFavorite: isFavorite,
                onFavoriteTap: () => context.read<MensaFavoriteCubit>().toggleFavoriteMensa(
                      mensaId: id,
                    ),
                onTap: () => context.go(
                  RouteNames.mensaDetails,
                  extra: MensaDetailsRouteArguments(
                    mensaModel: mensaModel,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Temporary method to get the title of the mensa, should be done in BE already
  String _getMensaNameWithoutType(String name) {
    List<String> parts = name.split(' ');

    return parts.sublist(1).join(' ');
  }

  // Temporary method to get the type of the mensa, should be done in BE already
  MensaType mapStringToMensaType(String input) {
    String firstPart = input.split(' ').first.toLowerCase();
    final Map<String, MensaType> stringToMensaTypeMap = {
      for (var type in MensaType.values) type.name.toLowerCase(): type
    };
    final mappedValue = stringToMensaTypeMap[firstPart];

    return mappedValue ?? MensaType.mensa;
  }

  MensaStatus getMensaStatus(MensaOpeningHours openingHours) {
    DateTime now = DateTime.now();
    MensaDayHours? todaysHours;

    switch (now.weekday) {
      case DateTime.monday:
        todaysHours = openingHours.mon;
        break;
      case DateTime.tuesday:
        todaysHours = openingHours.tue;
        break;
      case DateTime.wednesday:
        todaysHours = openingHours.wed;
        break;
      case DateTime.thursday:
        todaysHours = openingHours.thu;
        break;
      case DateTime.friday:
        todaysHours = openingHours.fri;
        break;
      default:
        return MensaStatus.closed; // Closed on weekends
    }

    // Parse start and end times
    DateTime startTime = DateTime(now.year, now.month, now.day, int.parse(todaysHours.start.split(":")[0]),
        int.parse(todaysHours.start.split(":")[1]));
    DateTime endTime = DateTime(now.year, now.month, now.day, int.parse(todaysHours.end.split(":")[0]),
        int.parse(todaysHours.end.split(":")[1]));

    if (now.isAfter(startTime) && now.isBefore(endTime)) {
      // Check if closing soon
      if (endTime.difference(now).inMinutes <= 30) {
        return MensaStatus.closingSoon;
      }
      return MensaStatus.open;
    }

    return MensaStatus.closed;
  }
}
