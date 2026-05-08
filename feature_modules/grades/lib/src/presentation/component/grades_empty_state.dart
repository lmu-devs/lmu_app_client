import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

class GradesEmptyState extends StatelessWidget {
  const GradesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final gradesL10n = context.locals.grades;

    return LmuEmptyState(
      hasVerticalPadding: true,
      type: EmptyStateType.custom,
      title: gradesL10n.emptyStateTitle,
      assetName: "lib/assets/no_grades.webp",
      description: gradesL10n.emptyStateDescription,
    );
  }
}
