import 'package:collection/collection.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/mensa_model.dart';
import '../services/mensa_user_preferences_service.dart';
import 'widgets.dart';

class MensaOverivewFavoriteSection extends StatefulWidget {
  const MensaOverivewFavoriteSection({
    super.key,
    required this.mensaModels,
  });

  final List<MensaModel> mensaModels;

  @override
  State<MensaOverivewFavoriteSection> createState() => _MensaOverivewFavoriteSectionState();
}

class _MensaOverivewFavoriteSectionState extends State<MensaOverivewFavoriteSection> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late _ListModel<MensaModel> _mensaList;
  late List<String> _favoriteMensaIds;

  @override
  void initState() {
    super.initState();
    final favoriteMensaIdsNotifier = GetIt.I<MensaUserPreferencesService>().favoriteMensaIdsNotifier;
    final initialFavoriteMensaIds = favoriteMensaIdsNotifier.value;
    _mensaList = _ListModel<MensaModel>(
      listKey: _listKey,
      initialItems: _getFavoriteMensaModels(initialFavoriteMensaIds),
      removedItemBuilder: (item, animation) => _MensaOverviewTileAnimationWrapper(
        animation: animation,
        mensaModel: item,
      ),
    );

    _favoriteMensaIds = List<String>.from(initialFavoriteMensaIds);
    _listenToFavoriteMensaIdChanges(favoriteMensaIdsNotifier);
  }

  void _listenToFavoriteMensaIdChanges(ValueNotifier<List<String>> favoriteMensaIdsNotifier) {
    favoriteMensaIdsNotifier.addListener(() {
      final newfavoriteMensaIds = List<String>.from(favoriteMensaIdsNotifier.value);
      final newMensaId = newfavoriteMensaIds.firstWhereOrNull((element) => !_favoriteMensaIds.contains(element));
      final removedMensaId = _favoriteMensaIds.firstWhereOrNull((element) => !newfavoriteMensaIds.contains(element));
      if (newMensaId != null) {
        _insert(widget.mensaModels.firstWhere((element) => element.canteenId == newMensaId));
      } else if (removedMensaId != null) {
        _remove(_mensaList.indexOf(_mensaList._items.firstWhere((element) => element.canteenId == removedMensaId)));
      }
      _favoriteMensaIds = newfavoriteMensaIds;
    });
  }

  void _insert(MensaModel mensaModel) {
    _mensaList.insert(0, mensaModel);
  }

  void _remove(int index) {
    _mensaList.removeAt(index);
  }

  List<MensaModel> _getFavoriteMensaModels(List<String> favoriteMensaIds) {
    return favoriteMensaIds.map((id) => widget.mensaModels.firstWhere((mensa) => mensa.canteenId == id)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      key: _listKey,
      initialItemCount: _mensaList.length,
      itemBuilder: (context, index, animation) {
        final mensaModel = _mensaList[index];

        return _MensaOverviewTileAnimationWrapper(
          animation: animation,
          mensaModel: mensaModel,
        );
      },
    );
  }
}

class _MensaOverviewTileAnimationWrapper extends StatelessWidget {
  const _MensaOverviewTileAnimationWrapper({
    required this.animation,
    required this.mensaModel,
  });

  final Animation<double> animation;
  final MensaModel mensaModel;

  @override
  Widget build(BuildContext context) {
    final fadeAnimation = CurvedAnimation(
      parent: animation,
      curve: LmuAnimations.gentle,
      reverseCurve: LmuAnimations.slowSmooth,
    );

    final sizeAnimation = CurvedAnimation(
      parent: animation,
      curve: LmuAnimations.gentle,
      reverseCurve: LmuAnimations.slowSmooth,
    );

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
      ),
      child: FadeTransition(
        opacity: fadeAnimation,
        child: SizeTransition(
          sizeFactor: sizeAnimation,
          child: MensaOverviewTile(
            mensaModel: mensaModel,
            isFavorite: true,
          ),
        ),
      ),
    );
  }
}

typedef RemovedItemBuilder<T> = Widget Function(T item, Animation<double> animation);

class _ListModel<E> {
  _ListModel({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final RemovedItemBuilder<E> removedItemBuilder;
  final List<E> _items;

  AnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList!.insertItem(
      index,
      duration: const Duration(
        milliseconds: 1200,
      ),
    );
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList!.removeItem(
        index,
        (_, Animation<double> animation) {
          return removedItemBuilder(removedItem, animation);
        },
        duration: const Duration(
          milliseconds: 800,
        ),
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
