import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../services/taste_profile_service.dart';

class TasteProfileToggleSection extends StatelessWidget {
  const TasteProfileToggleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isActiveNotifier = GetIt.I.get<TasteProfileService>().isActiveNotifier;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        children: [
          LmuContentTile(
            content: [
              ValueListenableBuilder(
                valueListenable: isActiveNotifier,
                builder: (context, isActive, _) {
                  return LmuListItem.action(
                    title: context.locals.canteen.myTaste,
                    actionType: LmuListItemAction.toggle,
                    mainContentAlignment: MainContentAlignment.center,
                    initialValue: isActive,
                    onChange: (value) => isActiveNotifier.value = value,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: LmuSizes.size_32),
        ],
      ),
    );
  }
}
