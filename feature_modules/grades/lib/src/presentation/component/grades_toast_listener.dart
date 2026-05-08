import 'dart:async';

import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../application/usecase/get_grades_usecase.dart';
import '../../application/usecase/grades_toast_service.dart';

class GradesToastListener extends StatefulWidget {
  const GradesToastListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<GradesToastListener> createState() => _GradesToastListenerState();
}

class _GradesToastListenerState extends State<GradesToastListener> {
  final _toastService = GetIt.I.get<GradesToastService>();
  final _usecase = GetIt.I.get<GetGradesUsecase>();
  late final StreamSubscription<GradesToastEvent> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _toastService.events.listen(_onEvent);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _onEvent(GradesToastEvent event) {
    if (!mounted) return;

    final gradesL10n = context.locals.grades;

    switch (event) {
      case GradeAddedEvent():
        LmuToast.show(
          context: context,
          message: gradesL10n.gradeAdded,
          type: ToastType.success,
        );
      case GradeSavedEvent():
        LmuToast.show(
          context: context,
          message: gradesL10n.gradeSaved,
          type: ToastType.success,
        );
      case GradeDeletedEvent(:final deletedGrade):
        LmuToast.show(
          context: context,
          message: gradesL10n.gradeDeleted,
          actionText: context.locals.app.undo,
          type: ToastType.success,
          onActionPressed: () => _usecase.addGrade(deletedGrade),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
