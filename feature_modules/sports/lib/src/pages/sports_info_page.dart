import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';

class SportsInfoPage extends StatelessWidget {
  const SportsInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: "Wie funktioniert ZHS? (WIP)",
      leadingAction: LeadingAction.back,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LmuText.body(
                "Das Basic-Ticket berechtigt zur Teilnahme am Zentralen Hochschulsport im jeweiligen Semester. Erst nach Buchung des Basic-Tickets hast du die Möglichkeit zur Onlineanmeldung für alle Sportkurse und das freie Spiel / Training",
              ),
              const SizedBox(height: LmuSizes.size_32),
              LmuTileHeadline.base(title: "Welches Ticket brauche ich für was?"),
              LmuContentTile(
                content: [
                  LmuListItem.base(
                    title: "Grundlage",
                    subtitle: "Basis-Ticket",
                    trailingTitle: "12€",
                    hasDivider: true,
                  ),
                  LmuListItem.base(
                    title: "Fitnessstudio Campus München",
                    subtitle: "Ticket-F",
                    trailingTitle: "30€",
                    hasDivider: true,
                  ),
                  LmuListItem.base(
                    title: "Fitnessstudio Campus Freising",
                    subtitle: "Ticket-T",
                    trailingTitle: "20€",
                    hasDivider: true,
                  ),
                  LmuListItem.base(
                    title: "Boulderanlagen",
                    subtitle: "Ticket-B",
                    trailingTitle: "50€",
                    trailingSubtitle: "(Halbzeit) 25€",
                    hasDivider: true,
                  ),
                  LmuListItem.base(
                    title: "Kletter-und Boulderanlagen",
                    subtitle: "Ticket-K",
                    trailingTitle: "100€",
                    trailingSubtitle: "(Halbzeit) 50€",
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_32),
              LmuTileHeadline.base(title: "Wie lange behält mein Ticket Gültigkeit?"),
              LmuText.body(
                "Ein Ticket gilt ab Kauf bis zum Ende des jeweiligen Semesters und muss für jedes Semester neu gebucht werden.",
              ),
              const SizedBox(height: LmuSizes.size_96),
            ],
          ),
        ),
      ),
    );
  }
}
