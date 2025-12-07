import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../domain/extension/session_model_extension.dart';
import '../../domain/model/session_model.dart';

class SessionTile extends StatelessWidget {
  const SessionTile({super.key, required this.session});

  static Widget loading() => const _SessionTileLoading();

  final SessionModel session;

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.courses;

    final hasStart =
        session.durationStart != null && session.durationStart!.isNotEmpty;
    final hasEnd =
        session.durationEnd != null && session.durationEnd!.isNotEmpty;

    final String durationSubtitle = hasStart ^ hasEnd
        ? localizations.courseDate
        : localizations.courseDuration;

    return LmuContentTile(
      contentList: [
        LmuListItem.base(
          subtitle: localizations.courseTime,
          trailingTitle: session.formattedTimeText(context),
          maximizeTrailingTitleArea: true,
        ),
        if (hasStart || hasEnd)
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

class _SessionTileLoading extends StatelessWidget {
  const _SessionTileLoading();

  @override
  Widget build(BuildContext context) {
    return LmuContentTile(
      contentList: [
        LmuListItem.base(
          subtitle: BoneMock.title,
          trailingTitle: BoneMock.subtitle,
          maximizeTrailingTitleArea: true,
        ),
        LmuListItem.base(
          subtitle: BoneMock.title,
          trailingTitle: "${BoneMock.time} - ${BoneMock.time}",
          maximizeTrailingTitleArea: true,
        ),
        LmuListItem.base(
          subtitle: BoneMock.title,
          trailingTitle: BoneMock.subtitle,
          maximizeTrailingTitleArea: true,
        ),
      ],
    );
  }
}
