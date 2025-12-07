import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/session_model.dart';
import '../component/session_tile.dart';
import '../viewmodel/sessions_details_page_driver.dart';

class SessionsDetailsPage extends DrivableWidget<SessionsDetailsPageDriver> {
  SessionsDetailsPage({
    super.key,
    required this.sessions,
  });

  final List<SessionModel> sessions;

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.pageTitle,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: LmuSizes.size_16,
          right: LmuSizes.size_16,
          bottom: LmuSizes.size_96,
        ),
        child: Column(
          children: sessions
              .map((session) => Padding(
                    padding: const EdgeInsets.only(top: LmuSizes.size_16),
                    child: SessionTile(session: session),
                  ))
              .toList(),
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<SessionsDetailsPageDriver> get driverProvider =>
      $SessionsDetailsPageDriverProvider(sessions: sessions);
}
