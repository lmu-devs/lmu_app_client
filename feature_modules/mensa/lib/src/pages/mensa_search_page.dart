import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core_routes/mensa.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/mensa_search_service.dart';
import '../widgets/common/mensa_tag.dart';

class MensaSearchEntry extends SearchEntry {
  const MensaSearchEntry({required super.title, required this.id});

  final String id;
}

class MensaSearchPage extends StatefulWidget {
  const MensaSearchPage({super.key});

  @override
  State<MensaSearchPage> createState() => _MensaSearchPageState();
}

class _MensaSearchPageState extends State<MensaSearchPage> {
  late final LmuRecentSearchController<MensaSearchEntry> _recentSearchController;
  late final List<MensaSearchEntry> _searchEntries;
  late final List<MensaSearchEntry> _recentSearchEntries;

  final _searchService = GetIt.I.get<MensaSearchService>();

  @override
  void initState() {
    super.initState();

    _recentSearchController = LmuRecentSearchController<MensaSearchEntry>();
    _searchEntries = _searchService.mensaModels
        .map((mensa) => MensaSearchEntry(title: "${mensa.name}${mensa.type.name}", id: mensa.canteenId))
        .toList();
    _recentSearchEntries = _searchService.recentSearchIds.map((id) {
      final mensaModel = _searchService.getMensaModel(id);
      return MensaSearchEntry(title: "${mensaModel.name}${mensaModel.type.name}", id: id);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LmuSearchPage<MensaSearchEntry>(
      searchEntries: _searchEntries,
      emptySearchEntriesTitle: "Popular",
      emptySearchEntries: _searchService.popularMensaModels
          .map((mensa) => MensaSearchEntry(title: "${mensa.name}${mensa.type.name}", id: mensa.canteenId))
          .toList(),
      recentSearchEntries: _recentSearchEntries,
      recentSearchController: _recentSearchController,
      onRecentSearchesUpdated: (recentSearchEntries) =>
          _searchService.updateRecentSearch(recentSearchEntries.map((e) => e.id).toList()),
      searchEntryBuilder: (MensaSearchEntry input) {
        final mensa = _searchService.getMensaModel(input.id);
        final tagData = mensa.type.getTagData(context.colors, context.locals.canteen);
        return LmuListItem.action(
          title: mensa.name,
          actionType: LmuListItemAction.chevron,
          titleInTextVisuals: [
            LmuInTextVisual.text(
              title: tagData.text,
              backgroundColor: tagData.backgroundColor,
              textColor: tagData.textColor,
            ),
          ],
          onTap: () {
            MensaDetailsRoute(mensa).push(context);
            Future.delayed(
              const Duration(milliseconds: 100),
              () => _recentSearchController.trigger(input),
            );
          },
        );
      },
    );
  }
}
