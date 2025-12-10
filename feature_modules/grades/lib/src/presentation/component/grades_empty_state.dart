import 'package:core/components.dart';
import 'package:flutter/material.dart';

class GradesEmptyState extends StatelessWidget {
  const GradesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuEmptyState(
      hasVerticalPadding: true,
      type: EmptyStateType.custom,
      title: "Keine Noten vorhanden",
      assetName: "lib/assets/no_grades.webp",
      description: "Füge deine ersten Noten hinzu, um deinen Durchschnitt zu berechnen.",
    );
  }
}
