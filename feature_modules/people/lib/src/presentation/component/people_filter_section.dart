import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/people.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class PeopleFilterSection extends StatelessWidget {
  const PeopleFilterSection({
    super.key,
    required this.isProfessorFilterActive,
    required this.onProfessorFilterToggle,
  });

  final bool isProfessorFilterActive;
  final VoidCallback onProfessorFilterToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: LmuTileHeadline.base(title: context.locals.people.allPeople),
        ),
        LmuButtonRow(
          buttons: [
            LmuIconButton(
              icon: LucideIcons.search,
              onPressed: () => const PeopleSearchRoute().go(context),
            ),
            LmuButton(
              title: context.locals.people.professorFilter,
              emphasis: isProfessorFilterActive ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
              action: isProfessorFilterActive ? ButtonAction.contrast : ButtonAction.base,
              onTap: onProfessorFilterToggle,
            ),
          ],
        ),
        const SizedBox(height: LmuSizes.size_16),
      ],
    );
  }
} 