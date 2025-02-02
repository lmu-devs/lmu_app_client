import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../widgets/sports_ticket_card.dart';

class SportsTicketsPage extends StatelessWidget {
  const SportsTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: "Tickets (WIP)",
      leadingAction: LeadingAction.back,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: Column(
            children: [
              const SizedBox(height: LmuSizes.size_8),
              LmuButton(
                emphasis: ButtonEmphasis.primary,
                showFullWidth: true,
                title: "Ticket hinzufügen",
                trailingIcon: LucideIcons.camera,
                onTap: () {
                  LmuToast.show(
                    context: context,
                    message: "Not implemented yet",
                  );
                },
              ),
              const SizedBox(height: LmuSizes.size_32),
              LmuTileHeadline.base(title: "Basis Ticket"),
              const SportsTicketCard(
                data: "Basis Ticket",
                name: "Max Mustermann",
                courseName: "Basis Ticket",
                timeSlot: "",
                validTimeFrame: "14.10.24 - 08.02.25",
                uniId: "S-LMU",
                id: "000001-123",
              ),
              const SizedBox(height: LmuSizes.size_32),
              LmuTileHeadline.base(title: "Kurs Tickets"),
              const SportsTicketCard(
                data: "Tischtennis Ticket",
                name: "Max Mustermann",
                courseName: "Tischtennis A1",
                timeSlot: "Mi 17:00 - 18:30",
                validTimeFrame: "14.10.24 - 08.02.25",
                uniId: "S-LMU",
                id: "000001-789",
              ),
              const SizedBox(height: LmuSizes.size_16),
              const SportsTicketCard(
                data: "Tischtennis Ticket",
                name: "Max Mustermann",
                courseName: "Tischtennis A1",
                timeSlot: "Mi 17:00 - 18:30",
                validTimeFrame: "10.02.25 - 16.04.25",
                uniId: "S-LMU",
                id: "000001-456",
              ),
              const SizedBox(height: LmuSizes.size_16),
              const SportsTicketCard(
                data: "Handball L Ticket",
                name: "Max Mustermann",
                courseName: "Handball L",
                timeSlot: "Mo 20:00 - 21:30",
                validTimeFrame: "14.10.24 - 08.02.25",
                uniId: "S-LMU",
                id: "000001-321",
              ),
              const SizedBox(height: LmuSizes.size_96),
            ],
          ),
        ),
      ),
    );
  }
}
