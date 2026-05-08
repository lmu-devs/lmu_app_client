import 'dart:async';

import '../../domain/model/grade.dart';

sealed class GradesToastEvent {
  const GradesToastEvent();
}

class GradeAddedEvent extends GradesToastEvent {
  const GradeAddedEvent();
}

class GradeSavedEvent extends GradesToastEvent {
  const GradeSavedEvent();
}

class GradeDeletedEvent extends GradesToastEvent {
  const GradeDeletedEvent(this.deletedGrade);

  final Grade deletedGrade;
}

class GradesToastService {
  final _controller = StreamController<GradesToastEvent>.broadcast();

  Stream<GradesToastEvent> get events => _controller.stream;

  void add(GradesToastEvent event) {
    _controller.add(event);
  }

  void dispose() {
    _controller.close();
  }
}
