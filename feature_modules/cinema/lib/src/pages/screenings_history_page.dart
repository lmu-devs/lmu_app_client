import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

import '../repository/api/models/screening_model.dart';
import '../widgets/screening_card.dart';

class ScreeningsHistoryPage extends StatelessWidget {
  const ScreeningsHistoryPage({
    super.key,
    required this.screenings,
  });

  final List<ScreeningModel> screenings;

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: context.locals.cinema.pastMoviesTitle,
      leadingAction: LeadingAction.back,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(screenings.length, (index) {
                final screening = screenings[index];
                return ScreeningCard(
                  screening: screening,
                  isLastItem: index == screenings.length - 1,
                );
              }),
              const SizedBox(height: LmuSizes.size_96),
            ],
          ),
        ),
      ),
    );
  }
}
