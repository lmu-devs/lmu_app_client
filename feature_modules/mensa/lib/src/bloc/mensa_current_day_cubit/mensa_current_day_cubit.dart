import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mensa/src/utils/mensa_day.dart';

class MensaCurrentDayCubit extends Cubit<MensaDay> {
  MensaCurrentDayCubit() : super(MensaDay.now());

  @override
  void onChange(Change<MensaDay> change) {
    super.onChange(change);
  }

  void setCurrentMensaDay({required MensaDay newMensaDay}) {
    emit(newMensaDay);
  }

  void incrementMensaDay() {
    final newMensaDay = state.addDuration(const Duration(days: 1));
    emit(newMensaDay);
  }

  void decrementMensaDay() {
    final newMensaDay = state.subtractDuration(const Duration(days: 1));
    emit(newMensaDay);
  }
}
