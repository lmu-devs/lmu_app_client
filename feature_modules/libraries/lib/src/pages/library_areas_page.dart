import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

import '../repository/api/api.dart';

class LibraryAreasPage extends StatelessWidget {
  const LibraryAreasPage({super.key, required this.library});

  final LibraryModel library;

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: context.locals.libraries.areas,
      leadingAction: LeadingAction.back,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: LmuSizes.size_16,
            right: LmuSizes.size_16,
            top: LmuSizes.size_8,
            bottom: LmuSizes.size_96,
          ),
          child: Column(
            children: library.areas
                .map(
                  (area) => Padding(
                    padding: const EdgeInsets.only(top: LmuSizes.size_8),
                    child: LmuContentTile(
                      content: LmuListItem.action(
                        actionType: LmuListItemAction.dropdown,
                        title: area.name,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
