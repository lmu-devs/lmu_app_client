import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/mensa_model.dart';
import '../services/mensa_user_preferences_service.dart';
import '../widgets/widgets.dart';

class MensaFavoriteTest extends StatefulWidget {
  const MensaFavoriteTest({super.key, required this.mensaModels});

  final List<MensaModel> mensaModels;

  @override
  State<MensaFavoriteTest> createState() => _MensaFavoriteTestState();
}

class _MensaFavoriteTestState extends State<MensaFavoriteTest> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late ListModel<MensaModel> _mensaList;

  @override
  void initState() {
    super.initState();
    final favoriteMensa =
        GetIt.I<MensaUserPreferencesService>().favoriteMensaIdsNotifier.value;
    _mensaList = ListModel<MensaModel>(
      listKey: _listKey,
      initialItems: _getFavoriteMensaModels(favoriteMensa),
      removedItemBuilder: _buildRemovedItem,
    );
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return CardItem(
      animation: animation,
      mensaModel: _mensaList[index],
      onFavoriteTap: () {
        _remove(index);
      },
    );
  }

  /// The builder function used to build items that have been removed.
  ///
  /// Used to build an item after it has been removed from the list. This method
  /// is needed because a removed item remains visible until its animation has
  /// completed (even though it's gone as far as this ListModel is concerned).
  /// The widget will be used by the [AnimatedListState.removeItem] method's
  /// [AnimatedRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(
      MensaModel item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      mensaModel: item,
      onFavoriteTap: () {},
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  // Insert the "next item" into the list model.
  void _insert(MensaModel mensaModel) {
    _mensaList.insert(0, mensaModel);
  }

  // Remove the selected item from the list model.
  void _remove(int index) {
    _mensaList.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: GetIt.I<MensaUserPreferencesService>().favoriteMensaIdsNotifier,
          builder: (context, value, child) {
            final newMensa = value.firstWhereOrNull((element) => !_mensaList._items.any((item) => item.canteenId == element));
            if(newMensa != null) _insert(widget.mensaModels.firstWhere((element) => element.canteenId == newMensa));
            return AnimatedList(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              key: _listKey,
              initialItemCount: _mensaList.length,
              
              itemBuilder: _buildItem,
            );
          }
        ),
      ],
    );
  }

  List<MensaModel> _getFavoriteMensaModels(List<String> favoriteMensaIds) {
    return favoriteMensaIds
        .map((id) =>
            widget.mensaModels.firstWhere((mensa) => mensa.canteenId == id))
        .toList();
  }
}

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value.
///
/// The text is displayed in bright green if [selected] is
/// true. This widget's height is based on the [animation] parameter, it
/// varies from 0 to 128 as the animation varies from 0.0 to 1.0.
class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.animation,
    required this.mensaModel,
    required this.onFavoriteTap,
  });

  final Animation<double> animation;
  final MensaModel mensaModel;
  final void Function() onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: MensaOverviewTile(
        mensaModel: mensaModel,
        isFavorite: true,
        onFavoriteTap: onFavoriteTap,
      ),
    );
  }
}

typedef RemovedItemBuilder<T> = Widget Function(
    T item, BuildContext context, Animation<double> animation);

/// Keeps a Dart [List] in sync with an [AnimatedList].
///
/// The [insert] and [removeAt] methods apply to both the internal list and
/// the animated list that belongs to [listKey].
///
/// This class only exposes as much of the Dart List API as is needed by the
/// sample app. More list methods are easily added, however methods that
/// mutate the list must make the same changes to the animated list in terms
/// of [AnimatedListState.insertItem] and [AnimatedList.removeItem].
class ListModel<E> {
  ListModel({
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
    _animatedList!.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return removedItemBuilder(removedItem, context, animation);
        },
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
