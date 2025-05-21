import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import '../../../../../core/lib/src/components/student_id/themes/themes.dart';

class IdCardPage extends StatelessWidget {
  const IdCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: "Student ID",
        leadingAction: LeadingAction.back,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(LmuSizes.size_16),
          child: HolographicCard(
            name: "John Doe",
            email: "john.doe@example.com",
            validUntil: "2025-12-31",
            matrikelnr: "1234567890",
            lrzKennung: "LRZ1234567890",
            braille: "⠇⠍⠥",
            width: 350,
            height: 220,
            borderRadius: 20,
            borderWidth: 2,
            // cardColor: LmuCardThemes.greenTheme.cardColor,
            // textColor: LmuCardThemes.greenTheme.textColor,
            // secondaryTextColor: LmuCardThemes.greenTheme.secondaryTextColor,
            // logoColor: LmuCardThemes.greenTheme.logoColor,
            // hologramColor: theme.hologramColor,
            // cardColor: Colors.white,
            //borderCardColor: LmuCardThemes.greenTheme.cardColor,
          ),
        ),
      ),
    );
  }
}
