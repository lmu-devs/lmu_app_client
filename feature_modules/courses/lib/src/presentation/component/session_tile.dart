import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

import '../../domain/extension/session_model_extension.dart';
import '../../domain/model/session_model.dart';

class SessionTile extends StatelessWidget {
  const SessionTile({super.key, required this.session});

  final SessionModel session;

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.courses;

    final hasStart = session.durationStart != null && session.durationStart!.isNotEmpty;
    final hasEnd = session.durationEnd != null && session.durationEnd!.isNotEmpty;

    String durationSubtitle;
    if (hasStart && !hasEnd) {
      durationSubtitle = localizations.courseStart;
    } else if (!hasStart && hasEnd) {
      durationSubtitle = localizations.courseEnd;
    } else {
      durationSubtitle = localizations.courseDuration;
    }

    return LmuContentTile(
      contentList: [
        LmuListItem.base(
          subtitle: localizations.courseTime,
          trailingTitle: session.formattedTimeText(context),
          maximizeTrailingTitleArea: true,
        ),
        LmuListItem.base(
          subtitle: durationSubtitle,
          trailingTitle: session.formattedDurationText,
          maximizeTrailingTitleArea: true,
        ),
        if (session.room != null && session.room!.isNotEmpty)
          LmuListItem.base(
            subtitle: localizations.courseRoom,
            trailingTitle: session.room!,
            maximizeTrailingTitleArea: true,
          ),
      ],
    );
  }
}
